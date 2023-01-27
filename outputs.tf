# Module: aws_messaging_msk
# Output Values: Output values make information about your infrastructure available on the command line,
#                and can expose information for other Terraform configurations to use.
#                Output values are similar to return values in programming languages.
output "bootstrap_brokers" {
  description = "Connection host:port pairs"
  value       = aws_msk_cluster.msk.bootstrap_brokers
}

output "bootstrap_brokers_tls" {
  description = "TLS connection host:port pairs"
  value       = aws_msk_cluster.msk.bootstrap_brokers_tls
}

output "environment" {
  description = "Environment name"
  value       = var.environment
}

output "profile" {
  description = "AWS Profile name"
  value       = var.profile
}

output "region" {
  description = "AWS Region name"
  value       = var.region
}

output "zookeeper_connect_string" {
  value = aws_msk_cluster.msk.zookeeper_connect_string
}

output "bucket" {
  description = "The bucket where the logs is stored"
  value       = length(aws_s3_bucket.bucket) > 0 ? aws_s3_bucket.bucket[0].bucket : ""
}
