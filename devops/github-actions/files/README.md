# {{PROJECT_NAME}} — GitHub Actions CI/CD

Pre-configured [GitHub Actions](https://docs.github.com/en/actions) workflows.

## Included Workflows

| Workflow | Trigger | Description |
|:---------|:--------|:------------|
| `ci.yml` | Push & PR to `{{DEPLOY_BRANCH}}` | Build, lint, and test |
| `deploy.yml` | Push to `{{DEPLOY_BRANCH}}` | Build and deploy |
| `release.yml` | Tag `v*` | Create GitHub release |

## Getting Started

1. Copy `.github/` into your repository root
2. Configure secrets in GitHub repo settings (Settings → Secrets)
3. Push to trigger workflows

## Customization

- Edit workflow files in `.github/workflows/`
- Add secrets via GitHub repo Settings → Secrets → Actions
- Modify `{{NODE_VERSION}}` in workflow matrices for version testing
