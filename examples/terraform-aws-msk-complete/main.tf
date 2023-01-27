# Usage Example Module: terraform-aws-msk-complete
# Description Terraform module to provision msk messaging in aws
locals {
  profile              = var.profile
  region               = var.region
}

module "terraform-aws-msk-complete" {
  source = "../.."

  building_block         = var.building_block
  environment            = var.environment
  instance_type          = "kafka.m5.xlarge"
  number_of_broker_nodes = 6
  kafka_version          = "3.2.0"
  volume_size            = 1000


  auto_create_topics_enable = true
  delete_topic_enable       = true

  client_authentication_unauthenticated_enabled = true

  prometheus_jmx_exporter  = true
  prometheus_node_exporter = true

  logs_enable = true

  s3_logs_prefix = "kafka-msk"

  encryption_in_transit_client_broker = "TLS_PLAINTEXT"
  encryption_in_transit_in_cluster    = true
  enhanced_monitoring                 = "PER_BROKER"

  tags = {
    my-tag = "terraform-kafka-complete"
  }
}
