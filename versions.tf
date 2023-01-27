terraform {
  required_version = ">= 1.3.3"

  provider_meta "terraform" {
    module_creation_date         = "2022-11-15_12:43"
    module_name                  = "terraform-aws-msk"
    module_version               = "0.1.0"
    module_description           = "Terraform module to provision msk messaging in aws"
    module_type                  = "platform"
    module_repo_url              = "https://github.com/mordp1/terraform-aws-msk"
    owner_team                   = "data"
    maintainer_name              = "mordp1"
    aws_provider_version         = "4.33.0"

  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.33.0"
    }
  }
}
