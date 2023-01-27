# Terraform *Usage Example* Module: terraform-aws-msk-complete

## Description
Terraform module to provision MSK Kafka messaging in AWS

## Usage

1. First things first, in AWS you may use the following CLI command in your local development environment to configure your credentials.

    ```bash
    aws configure sso
    ```

2. Then, provision resources with Terraform CLI:

    ```bash
    terraform init
    terraform plan # or terraform plan -var-file=iac.auto.tfvars
    terraform apply
    ```

3. Finally, remove all resources created before:

    ```bash
    terraform destroy
    ```

4. As a side note, take into account that `bootstap.tf` file contains a `backend` code block so that you can choose the needed backend type according to:
    - Being in an early development phase, choose `local` backend type.


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.3.3 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 4.33.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_terraform-aws-msk-complete"></a> [terraform\-aws\-msk\-complete](#module\_terraform\-aws\-msk\-complete) | ../.. | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_env_business"></a> [env\_business](#input\_env\_business) | The business name | `string` | `"XPTO"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment name | `string` | `"iac"` | no |
| <a name="input_profile"></a> [profile](#input\_profile) | AWS Profile name | `string` | `"aws-eu-west-1"` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS Region name | `string` | `"eu-west-1"` | no |
| <a name="input_subnet"></a> [subnet](#input\_subnet) | The subnet for MSK. In this case, the terraform just will find subnets with the word down below | `string` | `"private"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bootstrap_brokers"></a> [bootstrap\_brokers](#output\_bootstrap\_brokers) | Connection host:port pairs |
| <a name="output_bootstrap_brokers_tls"></a> [bootstrap\_brokers\_tls](#output\_bootstrap\_brokers\_tls) | TLS connection host:port pairs |
| <a name="output_bucket"></a> [bucket](#output\_bucket) | The bucket where the logs are stored |
| <a name="output_environment"></a> [environment](#output\_environment) | Environment name |
| <a name="output_profile"></a> [profile](#output\_profile) | AWS Profile name |
| <a name="output_region"></a> [region](#output\_region) | AWS Region name |
| <a name="output_zookeeper_connect_string"></a> [zookeeper\_connect\_string](#output\_zookeeper\_connect\_string) | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.msk-cluster](https://registry.terraform.io/providers/hashicorp/aws/4.33.0/docs/resources/cloudwatch_log_group) | resource |
| [aws_s3_bucket.bucket](https://registry.terraform.io/providers/hashicorp/aws/4.33.0/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_acl.bucket_acl](https://registry.terraform.io/providers/hashicorp/aws/4.33.0/docs/resources/s3_bucket_acl) | resource |
| [aws_s3_bucket_lifecycle_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/4.33.0/docs/resources/s3_bucket_lifecycle_configuration) | resource |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.33.0 |


<!-- END_TF_DOCS -->
