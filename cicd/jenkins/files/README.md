# {{PROJECT_NAME}}

A production-ready [Jenkins](https://www.jenkins.io/) CI/CD pipeline scaffold with declarative pipeline syntax, Docker agents, multi-stage builds, and shared library patterns.

## Getting Started

```bash
bash init.sh    # start Jenkins via Docker
bash run.sh     # open Jenkins UI
bash stop.sh    # stop Jenkins
```

## Prerequisites

- Docker & Docker Compose

## Project Structure

```
Jenkinsfile                     # Main declarative pipeline
docker-compose.yml              # Jenkins controller
jenkins/
  Dockerfile                    # Custom Jenkins image with plugins
  plugins.txt                   # Pre-installed plugins
  casc.yaml                     # Configuration as Code
pipelines/
  build.Jenkinsfile             # Build-only pipeline
  deploy.Jenkinsfile            # Deployment pipeline
scripts/
  build.sh                      # Build script
  test.sh                       # Test script
  deploy.sh                     # Deploy script
```

## Jenkins Access

After `bash init.sh`, Jenkins runs at **http://localhost:8080**.

Default credentials: `admin` / `admin` (set via Configuration as Code).

## Pipeline Features

- **Declarative syntax** with stages: Checkout → Build → Test → Analyze → Deploy
- **Docker agents** — each stage runs in an isolated container
- **Parameters** — branch, environment, skip-tests toggle
- **Parallel stages** — tests run in parallel (unit + integration)
- **Post actions** — always archive artifacts, notify on failure
- **Environment variables** from Jenkins credentials
