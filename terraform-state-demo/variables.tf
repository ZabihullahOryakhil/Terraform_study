variable "project" {
  type = string
  default = "state-demo"
}

variable "environment" {
  type = string
  default = "dev"
  
  validation {
    condition = contains(["dev", "stagin", "prod"], var.environment)
    error_message = "environment must be dev, staging, prod"
  }
}

variable "aws_region" {
  type = string
  default = "us-east-1"
}



variable "bucket_versioning" {
  type = bool
  default = false
}

variable "noncurrent_expiry_days" {
  type = number
  default = 30

  validation {
    condition = var.noncurrent_expiry_days >= 7
    error_message = "Must be at least 7 days"
  }
}

