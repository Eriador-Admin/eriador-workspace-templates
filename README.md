# eriador-workspace-templates

Public read-only template registry for the Belfalas IDE "New from Template" feature. Contains 150+ real, runnable project scaffolds organized by category.

> **Repo home:** [`Eriador-Admin/eriador-workspace-templates`](https://github.com/Eriador-Admin/eriador-workspace-templates) — public. Anyone can clone / fetch without credentials:
>
> ```bash
> git clone https://github.com/Eriador-Admin/eriador-workspace-templates.git
> ```

## How It Works

1. Templates are real project files on disk (not JSON/string representations)
2. The `belfalas-server-node` reads templates from a configurable `TEMPLATES_PATH`
3. Changes to templates are picked up automatically — no server or frontend redeployment required
4. CI validates structure, metadata, and cross-category ID uniqueness on every push

## Category Taxonomy

| Category | Description | Templates |
|----------|-------------|-----------|
| `frontend/` | Client-side web apps, SPAs, static sites | react-vite, next-app, vue-vite |
| `backend/` | APIs, servers, microservices | express-api, fastapi, spring-boot, go-fiber, rust-axum |
| `fullstack/` | Combined frontend + backend frameworks | fullstack-t3 |
| `database/` | Migrations, ORM starters, seed data projects | — |
| `mobile/` | Native and cross-platform mobile apps | react-native |
| `ml/` | Machine learning, data science, notebooks | flask-ml |
| `devops/` | Infrastructure, CI/CD, containerization | — |
| `library/` | Publishable packages, SDKs, monorepos | — |
| `documentation/` | Documentation sites, component docs | — |
| `other/` | Anything that doesn't fit above categories | empty |

## Directory Structure

```
eriador-workspace-templates/
├── .github/workflows/validate-templates.yml   ← CI validation
├── frontend/
│   ├── category.json                          ← Category metadata (optional; auto-discovered)
│   ├── react-vite/
│   │   ├── template.json                      ← Template metadata
│   │   └── files/                             ← Real project files
│   │       ├── package.json
│   │       ├── src/App.jsx
│   │       └── ...
│   ├── next-app/
│   └── vue-vite/
├── backend/
│   ├── category.json
│   ├── express-api/
│   ├── fastapi/
│   ├── spring-boot/
│   ├── go-fiber/
│   └── rust-axum/
├── fullstack/
├── database/
├── mobile/
├── ml/
├── devops/
├── library/
├── documentation/
└── other/
```

## Template Specification

Each template must have:
- `template.json` — metadata file with required fields
- `files/` — directory containing the real project files that get scaffolded

### Required `template.json` Fields

| Field | Type | Description |
|-------|------|-------------|
| `id` | string | Unique ID matching directory name. Pattern: `^[a-z0-9][a-z0-9-]{0,63}$` |
| `name` | string | Display name |
| `description` | string | Short description (≤ 200 chars) |
| `version` | string | Semver version |
| `category` | string | Must match parent folder name |
| `icon` | string | Emoji or icon identifier |
| `tech` | string[] | Technology tags shown as badges |

### Optional Fields

`difficulty`, `author`, `tags`, `subcategory`, `access`, `featured`, `sort_order`, `prerequisites`, `deprecated`, `deprecated_message`, `post_scaffold`, `variables`, `created_at`, `updated_at`

See the design document (in the parent monorepo at `documentation/workspace/WORKSPACE_TEMPLATES_DESIGN.md`) for full field specifications.

## Adding a New Category

Create a new folder at the repo root with a `category.json`:

```json
{
  "name": "gaming",
  "description": "Game development frameworks and engines"
}
```

No code changes required — the server and CI discover categories dynamically.

## Validation Rules

| Check | Limit |
|-------|-------|
| File count per template | ≤ 200 |
| Total size per template | ≤ 10MB |
| Directory depth | ≤ 20 levels |
| Description length | ≤ 200 chars |
| Template ID format | `^[a-z0-9][a-z0-9-]{0,63}$` |
| ID uniqueness | Global across all categories |

Templates exceeding 50 files or 5MB trigger a CI warning (not failure) — these will use tar.gz streaming at runtime.

## Branching Strategy

- `develop` — internal testing, used by staging environment
- `main` — production, used by production servers
- Feature branches → PR to `develop` → PR to `main`

The deployment sidecar uses `TEMPLATES_BRANCH` env var to select the branch.

## Related Documentation

- Workspace Templates Design Document (in parent monorepo at `documentation/workspace/WORKSPACE_TEMPLATES_DESIGN.md`)
- Implementation Plan (in parent monorepo at `documentation/IMPLEMENTATION_PLAN.md`)