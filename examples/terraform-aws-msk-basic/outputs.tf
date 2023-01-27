# Usage Example Module: aws_messaging_msk_basic
# Output Values: Output values make information about your infrastructure available on the command line,
#                and can expose information for other Terraform configurations to use.
#                Output values are similar to return values in programming languages.

output "zookeeper_connect_string" {
  value = module.aws_messaging_msk_basic.zookeeper_connect_string
}

output "bootstrap_brokers_tls" {
  description = "TLS connection host:port pairs"
  value       = module.aws_messaging_msk_basic.bootstrap_brokers_tls
}
output "bootstrap_brokers" {
  description = "Connection host:port pairs"
  value       = module.aws_messaging_msk_basic.bootstrap_brokers
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
