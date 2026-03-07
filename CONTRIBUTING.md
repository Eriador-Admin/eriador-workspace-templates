# Contributing to belfalas-workspace-templates

Thank you for contributing templates to the Belfalas IDE! This guide covers how to add, update, and test templates.

## Adding a New Template

### 1. Choose the Right Category

Pick the category folder that best fits your template:

| Category | For |
|----------|-----|
| `frontend/` | Client-side web apps, SPAs |
| `backend/` | APIs, servers, microservices |
| `fullstack/` | Combined frontend + backend |
| `database/` | Migrations, ORM starters |
| `mobile/` | Mobile apps |
| `ml/` | Machine learning, data science |
| `devops/` | Infrastructure, CI/CD |
| `library/` | Publishable packages, SDKs |
| `documentation/` | Documentation sites |
| `other/` | Everything else |

### 2. Create the Template Structure

```bash
mkdir -p <category>/<template-id>/files
```

The template ID must:
- Match the pattern `^[a-z0-9][a-z0-9-]{0,63}$`
- Be globally unique across all categories
- Match the directory name exactly

### 3. Create `template.json`

```json
{
  "id": "my-template",
  "name": "My Template",
  "description": "Brief description under 200 characters.",
  "version": "1.0.0",
  "category": "<must-match-parent-folder>",
  "icon": "🚀",
  "tech": ["Technology1", "Technology2"],
  "difficulty": "beginner",
  "author": "Your Name",
  "tags": ["searchable", "tags"],
  "access": "free",
  "deprecated": false,
  "post_scaffold": ["Open README.md", "Run npm install"],
  "created_at": "2026-03-06",
  "updated_at": "2026-03-06"
}
```

### 4. Add Real Project Files

Place your project files inside `files/`. These should be **real, runnable files** — not string representations.

```
<category>/<template-id>/
├── template.json
└── files/
    ├── package.json     ← real file
    ├── src/
    │   ├── index.js     ← real file
    │   └── ...
    ├── .gitignore       ← real file
    └── README.md        ← real file
```

### 5. Important Rules

- **No `.env` files**: Use `.env.example` or `.env.sample` instead (`.env` is blocked by the security ignore list)
- **No secrets or credentials**: Never include real API keys, tokens, or passwords
- **No binaries unless necessary**: Prefer text-based files; binary files are base64-encoded during scaffold
- **Max 200 files** per template
- **Max 10MB total** per template
- **Max 20 levels** of directory nesting
- **Description ≤ 200 characters**

### 6. Template Variables

Templates can use `{{VARIABLE_NAME}}` mustache syntax in any file. Variables are substituted during scaffolding.

**Reserved system variables** (auto-populated, do NOT declare in `template.json`):

| Variable | Description |
|----------|-------------|
| `{{PROJECT_NAME}}` | Name of the workspace being created |
| `{{AUTHOR}}` | Display name of the user scaffolding the template |
| `{{DATE}}` | Current date (YYYY-MM-DD) |
| `{{YEAR}}` | Current four-digit year |
| `{{TENANT_NAME}}` | Name of the user's organization/tenant |

**Custom variables** must be declared in the `variables` array of `template.json`:

```json
"variables": [
  {
    "name": "APP_NAME",
    "label": "Application Name",
    "type": "string",
    "default": "my-app",
    "required": false,
    "description": "Name for the project",
    "validation": "^[a-z][a-z0-9-]*$"
  }
]
```

Supported types: `string`, `number`, `boolean`, `choice`.

## Testing Checklist

Before submitting a PR, verify:

- [ ] `template.json` has all required fields (`id`, `name`, `description`, `version`, `category`, `icon`, `tech`)
- [ ] `id` matches the directory name
- [ ] `category` matches the parent folder name
- [ ] `description` is ≤ 200 characters
- [ ] `files/` directory exists and is non-empty
- [ ] No `.env` files (use `.env.example` instead)
- [ ] No secrets or credentials in any file
- [ ] File count ≤ 200
- [ ] Total size ≤ 10MB
- [ ] Template runs/builds correctly from the `files/` directory

## Local Validation

Run the CI validation script locally:

```bash
# From the repo root
bash validate.sh

# Quick manual check for a single template
node -e "
  const t = require('./<category>/<template>/template.json');
  const required = ['id','name','description','version','category','icon','tech'];
  const missing = required.filter(f => !t[f]);
  if (missing.length) console.error('Missing:', missing);
  else console.log('OK:', t.id, t.name);
"
```

## Branching Strategy

1. Create a feature branch from `develop`
2. Add/modify your template
3. Open a PR to `develop`
4. After review and merge, changes are available in staging
5. Promote to `main` via a separate PR for production release

See the design document (in the parent monorepo at `documentation/WORKSPACE_TEMPLATES_DESIGN.md`) Section 12 for full branching details.

## Updating an Existing Template

1. Bump the `version` field in `template.json`
2. Update `updated_at` date
3. Modify files as needed
4. Follow the same PR process

## Access Control Tiers

The `access` field controls which plan tiers can use a template:

| Value | Who Can Access |
|-------|----------------|
| `"free"` (default) | All plans |
| `"individual"` | Individual, Pro, Enterprise |
| `"pro"` | Pro, Enterprise |
| `"enterprise"` | Enterprise only |
