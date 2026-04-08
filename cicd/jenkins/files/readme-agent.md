# Agent Instructions — {{PROJECT_NAME}}

This is a Jenkins CI/CD pipeline project using declarative pipeline syntax.

## Tech Stack
- **CI/CD**: Jenkins 2.x (LTS)
- **Pipeline**: Declarative Jenkinsfile (Groovy DSL)
- **Agents**: Docker-based
- **Config**: Jenkins Configuration as Code (JCasC)

## Key Conventions
- Use declarative `pipeline {}` syntax, not scripted
- Stages: Checkout → Build → Test → Analyze → Deploy
- Docker agent per stage for isolation: `agent { docker { image '...' } }`
- Parameters: `string`, `choice`, `booleanParam` at pipeline level
- Parallel stages via `parallel {}` block inside a stage
- `when` conditions guard stages (e.g., deploy only on main branch)
- Post: `always`, `success`, `failure` blocks for cleanup/notifications
- Credentials via `withCredentials` or `environment { VAR = credentials('id') }`
- Shared scripts in `scripts/` — called from pipeline via `sh './scripts/build.sh'`
- plugins.txt pre-installs required plugins in Docker image
- casc.yaml configures Jenkins declaratively (users, security, tools)
