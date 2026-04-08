# Agent Instructions — {{PROJECT_NAME}}

This is a GitHub Actions CI/CD template project.

## Tech Stack
- **Platform**: GitHub Actions
- **Language**: YAML workflow definitions

## Key Conventions
- Workflows live in `.github/workflows/`
- CI runs on push and PRs to `{{DEPLOY_BRANCH}}`
- Deploy only triggers on push to `{{DEPLOY_BRANCH}}`
- Release triggers on version tags (`v*`)
- Use GitHub Secrets for sensitive configuration

## File Patterns
- `.github/workflows/*.yml` → Workflow definitions
- Each workflow has `name`, `on` (trigger), and `jobs` sections
