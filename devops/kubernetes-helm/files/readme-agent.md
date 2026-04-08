# Agent Instructions — {{CHART_NAME}}

This is a Kubernetes Helm chart project.

## Tech Stack
- **Tool**: Helm 3+
- **Target**: Kubernetes cluster
- **Language**: YAML with Go templates

## Key Conventions
- Chart definition in `chart/Chart.yaml`
- Default values in `chart/values.yaml`
- Templates in `chart/templates/` use Go template syntax
- Helper functions in `chart/templates/_helpers.tpl`
- Override values per environment via separate values files

## File Patterns
- `chart/templates/*.yaml` → Kubernetes manifests with Helm templating
- `chart/templates/_helpers.tpl` → Reusable template definitions
- `chart/values.yaml` → Default configuration
- `values-*.yaml` → Environment-specific overrides
