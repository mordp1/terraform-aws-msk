# Usage Example Module: aws_messaging_msk_basic
# Input variables: Let you customize aspects of Terraform modules without altering the module's own source code.
#                  This functionality allows you to share modules across different Terraform configurations,
#                  making your module composable and reusable.

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "iac"
}

variable "profile" {
  description = "AWS Profile name"
  type        = string
  default     = "my-profile"
}

variable "building_block" {
  description = "Building Block"
  type        = string
}

variable "region" {
  description = "AWS Region name"
  type        = string
  default     = "eu-west-1"
}