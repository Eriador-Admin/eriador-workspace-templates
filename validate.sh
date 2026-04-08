#!/bin/bash
# validate.sh - Local CI validation for template repository
set -euo pipefail

cd "$(dirname "$0")"

RESERVED="node_modules .git"
ERRORS=0
TEMPLATES=0

echo "=== Validating Template Structure ==="
echo ""

for category in */; do
  category="${category%/}"
  echo "$RESERVED" | grep -qw "$category" && continue
  [ ! -d "$category" ] && continue
  # Only process directories that have a category.json
  [ ! -f "$category/category.json" ] && continue

  # Validate category.json schema
  if ! node -e "
    const c = require('./$category/category.json');
    if (!c.name || !c.description) {
      console.error('$category/category.json missing required name or description');
      process.exit(1);
    }
  "; then ERRORS=$((ERRORS+1)); continue; fi

  for dir in "$category"/*/; do
    dir="${dir%/}"
    tpl_name=$(basename "$dir")
    [ ! -d "$dir" ] && continue

    # Must have template.json
    if [ ! -f "$dir/template.json" ]; then
      echo "ERROR: $dir missing template.json"
      ERRORS=$((ERRORS+1))
      continue
    fi

    # Validate template ID format (before interpolating into JS strings)
    if ! [[ "$tpl_name" =~ ^[a-z0-9][a-z0-9-]{0,63}$ ]]; then
      echo "ERROR: $dir: template ID '$tpl_name' does not match ^[a-z0-9][a-z0-9-]{0,63}$"
      ERRORS=$((ERRORS+1))
      continue
    fi

    # Validate with node
    if ! node -e "
      const t = require('./$dir/template.json');
      const required = ['id','name','description','version','category','icon','tech'];
      const missing = required.filter(function(f) { return !t[f]; });
      if (missing.length) {
        console.error('$dir/template.json missing:', missing.join(', '));
        process.exit(1);
      }
      if (t.id !== '$tpl_name') {
        console.error('$dir/template.json id mismatch: expected $tpl_name, got', t.id);
        process.exit(1);
      }
      if (t.category !== '$category') {
        console.error('$dir/template.json category mismatch: expected $category, got', t.category);
        process.exit(1);
      }
      if (t.description && t.description.length > 200) {
        console.error('$dir/template.json description exceeds 200 chars');
        process.exit(1);
      }
      if (t.categories) {
        if (!Array.isArray(t.categories)) {
          console.error('$dir/template.json categories must be an array');
          process.exit(1);
        }
        const fs = require('fs');
        if (t.categories.length === 0) {
          console.error('$dir/template.json categories must not be empty');
          process.exit(1);
        }
        if (t.categories[0] !== t.category) {
          console.error('$dir/template.json categories[0] must match primary category:', t.category, 'got', t.categories[0]);
          process.exit(1);
        }
        const seen = new Set();
        for (const c of t.categories) {
          if (typeof c !== 'string') {
            console.error('$dir/template.json categories entries must be strings');
            process.exit(1);
          }
          if (seen.has(c)) {
            console.error('$dir/template.json categories has duplicate:', c);
            process.exit(1);
          }
          seen.add(c);
          if (!fs.existsSync(c + '/category.json')) {
            console.error('$dir/template.json categories references unknown category:', c);
            process.exit(1);
          }
        }
      }
      if (t.composes) {
        if (!Array.isArray(t.composes)) {
          console.error('$dir/template.json composes must be an array');
          process.exit(1);
        }
        for (const cid of t.composes) {
          if (typeof cid !== 'string') {
            console.error('$dir/template.json composes entries must be strings');
            process.exit(1);
          }
        }
      }
    "; then ERRORS=$((ERRORS+1)); continue; fi

    # Must have files/ directory with at least one file
    if [ ! -d "$dir/files" ] || [ -z "$(ls -A "$dir/files")" ]; then
      echo "ERROR: $dir/files/ is missing or empty"
      ERRORS=$((ERRORS+1))
      continue
    fi

    count=$(find "$dir/files" -type f | wc -l)
    # macOS du doesn't support -b; use find + stat for byte-accurate size
    if du -sb /dev/null &>/dev/null; then
      size=$(du -sb "$dir/files" | cut -f1)
    else
      size=$(find "$dir/files" -type f -exec stat -f%z {} + 2>/dev/null | awk '{s+=$1} END {print s+0}')
    fi

    if [ "$count" -gt 200 ]; then
      echo "ERROR: $dir has $count files (max 200)"
      ERRORS=$((ERRORS+1))
      continue
    fi

    if [ "$size" -gt 10485760 ]; then
      echo "ERROR: $dir is $(($size/1048576))MB (max 10MB)"
      ERRORS=$((ERRORS+1))
      continue
    fi

    if [ "$count" -gt 50 ]; then
      echo "WARN: $dir has $count files (>50, will use tar streaming)"
    fi
    if [ "$size" -gt 5242880 ]; then
      echo "WARN: $dir is $(($size/1048576))MB (>5MB, will use tar streaming)"
    fi

    # Check for max directory depth (matches CI pipeline)
    base_depth=$(echo "$dir/files" | awk -F/ '{print NF}')
    max_depth=$(find "$dir/files" -type d | awk -F/ '{print NF}' | sort -rn | head -1)
    rel_depth=$(( max_depth - base_depth ))
    if [ -n "$rel_depth" ] && [ "$rel_depth" -gt 20 ]; then
      echo "ERROR: $dir exceeds max directory depth of 20 levels"
      ERRORS=$((ERRORS+1))
      continue
    fi

    # Ensure no .env files are included (secrets risk)
    if find "$dir/files" -name '.env' -type f | grep -q .; then
      echo "ERROR: $dir/files/ contains a .env file (use .env.example instead)"
      ERRORS=$((ERRORS+1))
      continue
    fi

    # Check for undeclared mustache variables
    if ! node -e "
      const fs = require('fs');
      const path = require('path');
      const t = require('./$dir/template.json');
      const SYSTEM_VARS = new Set(['PROJECT_NAME','AUTHOR','DATE','YEAR','TENANT_NAME']);
      const declared = new Set((t.variables || []).map(function(v) { return v.name; }));
      const all = new Set([...SYSTEM_VARS, ...declared]);
      let ok = true;
      function scan(dir) {
        for (const entry of fs.readdirSync(dir, {withFileTypes:true})) {
          const full = path.join(dir, entry.name);
          if (entry.isDirectory()) { scan(full); continue; }
          try {
            const content = fs.readFileSync(full, 'utf-8');
            const matches = content.match(/\\{\\{([A-Z0-9_]+)\\}\\}/g) || [];
            for (const m of matches) {
              const name = m.slice(2, -2);
              if (!all.has(name)) {
                console.error('$dir: undeclared variable {{' + name + '}} in', path.relative('.', full));
                ok = false;
              }
            }
          } catch(e) {} // skip binary files
        }
      }
      scan('./$dir/files');
      if (!ok) process.exit(1);
    "; then ERRORS=$((ERRORS+1)); continue; fi

    echo "OK: $category/$tpl_name ($count files, $(($size/1024))KB)"
    TEMPLATES=$((TEMPLATES+1))
  done
done

echo ""
echo "=== Cross-Category ID Uniqueness Check ==="
node -e "
  const fs = require('fs');
  const path = require('path');
  const RESERVED = new Set(['.github', 'node_modules', '.git']);
  const ids = new Map();
  let errors = 0;
  const cats = fs.readdirSync('.', {withFileTypes: true})
    .filter(function(d) { return d.isDirectory() && !RESERVED.has(d.name) && !d.name.startsWith('.'); });
  for (const cat of cats) {
    const tpls = fs.readdirSync(cat.name, {withFileTypes: true}).filter(function(d) { return d.isDirectory(); });
    for (const tpl of tpls) {
      const metaPath = path.join(cat.name, tpl.name, 'template.json');
      if (!fs.existsSync(metaPath)) continue;
      const meta = JSON.parse(fs.readFileSync(metaPath, 'utf-8'));
      if (ids.has(meta.id)) {
        console.error('DUPLICATE ID:', meta.id, 'found in', cat.name + '/' + tpl.name, 'and', ids.get(meta.id));
        errors++;
      } else {
        ids.set(meta.id, cat.name + '/' + tpl.name);
      }
    }
  }
  if (errors > 0) { console.error(errors, 'duplicate ID(s) found'); process.exit(1); }
  console.log('All', ids.size, 'template IDs are unique across categories');
"

echo ""
echo "=== Summary ==="
echo "Templates validated: $TEMPLATES"
echo "Errors: $ERRORS"

if [ $ERRORS -gt 0 ]; then
  echo "FAILED: $ERRORS template(s) have errors"
  exit 1
else
  echo "ALL TEMPLATES PASSED"
fi
