# {{PROJECT_NAME}}

GitLab CI/CD pipeline templates for a full build-test-deploy workflow.

## Getting Started

```bash
bash init.sh    # validate pipeline config
bash run.sh     # (pipelines run on GitLab, not locally)
bash stop.sh    # no-op
```

## Pipeline Structure

```
.gitlab-ci.yml          # Main pipeline definition
ci/
  templates/
    docker.yml          # Docker build & push jobs
    test.yml            # Testing jobs
    deploy.yml          # Deploy jobs per environment
  scripts/
    notify.sh           # Slack/webhook notification
```

## Stages

1. **lint** — ESLint / code quality checks
2. **test** — Unit + integration tests with coverage
3. **build** — Docker image build + push to registry
4. **deploy:staging** — Auto-deploy to staging
5. **deploy:production** — Manual deploy to production

## Variables Required

Set these in GitLab > Settings > CI/CD > Variables:

| Variable | Description |
|----------|-------------|
| `DOCKER_REGISTRY` | Container registry URL |
| `DOCKER_USER` | Registry username |
| `DOCKER_PASSWORD` | Registry password |
| `STAGING_HOST` | Staging server SSH host |
| `PRODUCTION_HOST` | Production server SSH host |
| `SSH_PRIVATE_KEY` | Deploy key for SSH access |

## Requirements

- GitLab repository with CI/CD enabled
- Docker registry access
- Target servers with SSH access
