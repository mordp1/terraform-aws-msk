# Usage Example Module: aws_messaging_msk_basic
# Output Values: Output values make information about your infrastructure available on the command line,
#                and can expose information for other Terraform configurations to use.
#                Output values are similar to return values in programming languages.

output "zookeeper_connect_string" {
  value = module.terraform-aws-msk-complete.zookeeper_connect_string
}

output "bootstrap_brokers_tls" {
  description = "TLS connection host:port pairs"
  value       = module.terraform-aws-msk-complete.bootstrap_brokers_tls
}
output "bootstrap_brokers" {
  description = "Connection host:port pairs"
  value       = module.terraform-aws-msk-complete.bootstrap_brokers
}

output "bucket_name" {
  description = "Name bucket"
  value       = module.terraform-aws-msk-complete.bucket
}


output "environment" {
  description = "Environment name"
  value       = var.environment
}

output "profile" {
  description = "AWS Profile name"
  value       = local.profile
}

output "region" {
  description = "AWS Region name"
  value       = local.region
}

