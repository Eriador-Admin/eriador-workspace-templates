# Agent Instructions — {{PROJECT_NAME}}

This is a Terraform Infrastructure as Code project.

## Tech Stack
- **Tool**: Terraform (HCL)
- **Provider**: {{CLOUD_PROVIDER}}
- **Pattern**: Modular with per-environment configs

## Key Conventions
- Environments in `environments/` — each has its own backend and variable values
- Reusable modules in `modules/` — called from environment configs
- Variables defined in `variables.tf`, values in `terraform.tfvars`
- Outputs defined in `outputs.tf`
- State stored remotely (configure backend in `main.tf`)

## File Patterns
- `*.tf` — Terraform configuration (HCL)
- `terraform.tfvars` — Variable values (do NOT commit secrets)
- `.terraform/` — Provider plugins (gitignored)
- `.terraform.lock.hcl` — Dependency lock file (commit this)
