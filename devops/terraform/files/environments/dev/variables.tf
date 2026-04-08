variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "{{PROJECT_NAME}}"
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "{{AWS_REGION}}"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}
