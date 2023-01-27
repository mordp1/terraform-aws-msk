# AWS Provider Configuration
provider "aws" {
#  profile = local.profile
  region  = local.region
}

# Backend configuration
terraform {
  backend "local" {}

  # 
  # backend "s3" {
  #   bucket         = ""
  #   key            = ""
  #   region         = "eu-west-1"
  #   profile        = "terraform-backend"
  #   dynamodb_table = "TerraformStatesBackend"
  # }

  # # new Artifactory backend
  # backend "remote" {
  #   hostname = ""
  #   organization = "terraform-backend"
  #   workspaces {
  #     prefix = "prefix-"
  # }
}
