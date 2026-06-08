variable "environment" {
  type = string
  default = "dev"
  validation {
    condition = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Must be dev, staging, or prod."
  }
}

variable "aws_region" {
  type = string
  default = "us-east-1"
}

variable "owner" {
  type = string
}
