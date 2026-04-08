# {{PROJECT_NAME}}

Infrastructure as Code using [Terraform](https://www.terraform.io/).

## Getting Started

```bash
bash init.sh    # initialize Terraform
bash run.sh     # plan and apply infrastructure
bash stop.sh    # destroy infrastructure
```

## Project Structure

```
environments/
  dev/           # Dev environment configuration
  prod/          # Production environment configuration
modules/
  vpc/           # Reusable VPC module
```

## Usage

```bash
cd environments/dev
terraform init
terraform plan
terraform apply
```

## Requirements

- [Terraform](https://developer.hashicorp.com/terraform/downloads) >= 1.5
- Cloud provider credentials configured (AWS CLI, gcloud, etc.)
