# Usage Example Module: aws_messaging_msk_basic
# Description Terraform module to provision msk messaging in aws
locals {
  profile              = "default"
  region               = var.region
}

module "aws_messaging_msk_basic" {
  source = "../.."

  environment            = var.environment
  building_block         = var.building_block
  number_of_broker_nodes = 3
  kafka_version          = "3.2.0"

  tags = {
    my-tag = "terraform-kafka-basic"
  }
}
