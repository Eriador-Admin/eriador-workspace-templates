# {{CHART_NAME}}

A [Helm](https://helm.sh/) chart for deploying to Kubernetes.

## Getting Started

```bash
bash init.sh    # lint the chart
bash run.sh     # install/upgrade the release
bash stop.sh    # uninstall the release
```

## Chart Structure

```
chart/
  Chart.yaml         # Chart metadata
  values.yaml        # Default configuration values
  templates/
    deployment.yaml  # Deployment manifest
    service.yaml     # Service manifest
    ingress.yaml     # Ingress manifest
    _helpers.tpl     # Template helpers
```

## Usage

```bash
# Install
helm install {{CHART_NAME}} ./chart

# Upgrade with custom values
helm upgrade {{CHART_NAME}} ./chart -f custom-values.yaml

# Dry run
helm install {{CHART_NAME}} ./chart --dry-run --debug
```

## Requirements

- [Helm](https://helm.sh/docs/intro/install/) >= 3.0
- Access to a Kubernetes cluster (`kubectl` configured)
