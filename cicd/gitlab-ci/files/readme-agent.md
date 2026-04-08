# Agent Instructions — {{PROJECT_NAME}}

This is a GitLab CI/CD pipeline project.

## Tech Stack
- **CI/CD**: GitLab CI
- **Container**: Docker
- **Config**: YAML

## Key Conventions
- Main pipeline: `.gitlab-ci.yml`
- Reusable templates in `ci/templates/`
- Helper scripts in `ci/scripts/`
- Uses `include` for modular pipeline config
- Stages: lint → test → build → deploy
- Production deploy requires manual approval
