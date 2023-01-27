## References

Module is based from [angelabad/terraform-aws-msk-cluster](https://github.com/angelabad/terraform-aws-msk-cluster) / [terraform-msk-cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/msk_cluster) / [AWS MSK API Reference](https://docs.aws.amazon.com/msk/1.0/apireference/clusters.html)

This module adapts to allow passing configuration to get the networking resources id and define configurations to use Amazon MSK and not create any resource regarding the Networking side.

## Considerations 

When we can try to update something regarding MSK, we will see this error below. So keep in mind at the moment this is a kind off "bug" → https://github.com/hashicorp/terraform-provider-aws/issues/15795


> Error: Provider produced inconsistent final plan
>
>When expanding the plan for module.terraform-aws-msk-complete.aws_msk_cluster.msk to include new values learned so far during apply, provider "registry.terraform.io/hashicorp/aws" changed the
>planned action from NoOp to Update.
>
>This is a bug in the provider, which should be reported in the provider's own issue tracker.
>
>
>Error: Provider produced inconsistent final plan
>
>When expanding the plan for module.terraform-aws-msk-complete.aws_msk_cluster.msk to include new values learned so far during apply, provider "registry.terraform.io/hashicorp/aws" produced an
>invalid new value for .configuration_info[0].revision: was cty.NumberIntVal(1), but now cty.NumberIntVal(2). 
>
This is a bug in the provider, which should be reported in the provider's own issue tracker.


**The update creates a new revision of the configuration, which is as expected. `A second apply must be performed` to update a msk_cluster to the new revision, however.**

## Usage with Docker or Podman with terraform image.
Just make sure you can run docker or podman in your development environment and execute (maybe, you should use with root permission):
Must configure .env.aws

```
make docker-sh
make podman-sh    
```


## Contributing to terraform-aws-msk
This module follows the principles of [**Semantic Versioning (SemVer)**](https://semver.org/). Therefore, **always use release tags** when *sourcing* as a dependency to ensure that you get compatible code. Using the given version number of `MAJOR.MINOR.PATCH`, we apply the following constructs:
1. Use the `MAJOR` version for incompatible changes.
2. Use the `MINOR` version when adding functionality in a backwards compatible manner.
3. Use the `PATCH` version when introducing backwards compatible bug fixes.

In this sense, any contribution to this project must follow these guidelines:
- The file CHANGELOG.md MUST reflect all the changes introduced in the project.
- In case of introducing a Breaking Change (a backwards incompatible change) remember to upgrade the `MAJOR` number and **DOCUMENT in `UPGRADING.md`** how to go from one version to another (from the older major to the newer one).
- Always keep as much as possible this README.md file up-to-date, specially if any project's processes changes.

### Notes
- **Initial Development Phase**:
  - In the context of initial development, backwards compatibility in versions `0.y.z` is **not guaranteed** when `z` or `y` are increased.
  - In other words, if the major release is `0`, any minor release may contain breaking changes.
- **First public release** of this module requires tagging it as version `1.0.0`.
- The **master branch** contains all the latest code, some of which may **break compatibility** with previous versions.
- Running a CloudBees pipeline after a PR is merged generates (publish) a Terraform Artifact (a module package) in JFrog Artifactory. If CloudBees pipeline is launched again *with the same versioning information* it would try to re-publish the Terraform Artifact *with the same version tag*, resulting into a failure so to avoid overriding the previously generated artifact.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.3.3 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 4.33.0 |



## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_auto_create_topics_enable"></a> [auto\_create\_topics\_enable](#input\_auto\_create\_topics_enable) | A config for Kafka server.properties | `bool` | `false` | no |
| <a name="input_building_block"></a> [building\_block](#input\_building\_block) | Building Block. | `string` |   | yes |
| <a name="input_client_authentication_unauthenticated_enabled"></a> [client\_authentication\_unauthenticated\_enabled](#input\_client\_authentication\_unauthenticated\_enabled) | Enables unauthenticated access. | `bool` | `true` | no |
| <a name="input_cloudwatch_logs_group"></a> [cloudwatch\_logs\_group](#input\_cloudwatch\_logs\_group) | Name of the Cloudwatch Log Group to deliver logs to. | `string` | `""` | no |
| <a name="input_delete_topic_enable"></a> [delete\_topic\_enable](#delete\_topic\_enable) | A config for Kafka server.properties| `bool` | `false` | no |
| <a name="input_encryption_in_transit_client_broker"></a> [encryption\_in\_transit\_client\_broker](#input\_encryption\_in\_transit\_client\_broker) | Encryption setting for data in transit between clients and brokers. Valid values: TLS, TLS\_PLAINTEXT, and PLAINTEXT. Default value is TLS\_PLAINTEXT. | `string` | `"TLS_PLAINTEXT"` | no |
| <a name="input_encryption_in_transit_in_cluster"></a> [encryption\_in\_transit\_in\_cluster](#input\_encryption\_in\_transit\_in\_cluster) | Whether data communication among broker nodes is encrypted. Default value: true. | `bool` | `false` | no |
| <a name="input_enhanced_monitoring"></a> [enhanced\_monitoring](#input\_enhanced\_monitoring) | Specify the desired enhanced MSK CloudWatch monitoring level to one of three monitoring levels: DEFAULT, PER\_BROKER, PER\_TOPIC\_PER\_BROKER or PER\_TOPIC\_PER\_PARTITION. See [Monitoring Amazon MSK with Amazon CloudWatch](https://docs.aws.amazon.com/msk/latest/developerguide/monitoring.html). | `string` | `"DEFAULT"` | no |
| <a name="input_env_business"></a> [env\_business](#input\_env\_business) | The business name | `string` | `"XPTO"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) |  Environment name | `string` | `"iac"` | yes |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Specify the instance type to use for the kafka brokers. e.g. kafka.m5.large. | `string` | `"kafka.t3.small"` | yes |
| <a name="input_kafka_version"></a> [kafka\_version](#input\_kafka\_version) | Specify the desired Kafka software version. | `string` | `"3.2.0"` | yes |
| <a name="input_logs_enable"></a> [logs_enable](#input\_logs\_enable) | To enable the creation of a S3 Bucket to save the logs| `bool` | `"false"` | no |
| <a name="input_number_of_broker_nodes"></a> [number\_of\_broker\_nodes](#input\_number\_of\_broker\_nodes) | The desired total number of broker nodes in the kafka cluster. It must be a multiple of the number of specified client subnets. | `number` | `"3"`| yes |
| <a name="input_prometheus_jmx_exporter"></a> [prometheus\_jmx\_exporter](#input\_prometheus\_jmx\_exporter) | Indicates whether you want to enable or disable the JMX Exporter. | `bool` | `false` | no |
| <a name="input_prometheus_node_exporter"></a> [prometheus\_node\_exporter](#input\_prometheus\_node\_exporter) | Indicates whether you want to enable or disable the Node Exporter. | `bool` | `false` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS Region name | `string` | `"eu-west-1"` | no |
| <a name="input_s3_logs_bucket"></a> [s3\_logs\_bucket](#input\_s3\_logs\_bucket) | Name of the S3 bucket to deliver logs to. | `string` | `""` | no |
| <a name="input_s3_logs_prefix"></a> [s3\_logs\_prefix](#input\_s3\_logs\_prefix) | Prefix to append to the folder name. | `string` | `""` | no |
| <a name="input_security_groups_names"></a> [security\_groups\_names](#input\_security\_groups\_names) | A list of extra security groups to associate with the elastic network interfaces to control who can communicate with the cluster. | `list(string)` | `[]` | no |
| <a name="input_server_properties"></a> [server\_properties](#input\_server\_properties) | A map of the contents of the server.properties file. Supported properties are documented in the [MSK Developer Guide](https://docs.aws.amazon.com/msk/latest/developerguide/msk-configuration-properties.html). | `map(string)` | `{}` | no |
| <a name="input_set_name"></a> [set\_name](#input\_set\_name) | Service set | `string` | `null` | no |
| <a name="input_subnet"></a> [subnet](#input\_subnet) | A tag Name of subnets to find and connect to in client VPC | `string` | `"private"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |
| <a name="input_volume_size"></a> [volume\_size](#input\_volume\_size) | The size in GiB of the EBS volume for the data drive on each broker node. | `number` | `100` | no |

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
| [aws_cloudwatch_log_group](https://registry.terraform.io/providers/hashicorp/aws/4.33.0/docs/resources/cloudwatch_log_group) | resource |
| [aws_msk_cluster.msk](https://registry.terraform.io/providers/hashicorp/aws/4.33.0/docs/resources/msk_cluster) | resource |
| [aws_msk_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/4.33.0/docs/resources/msk_configuration) | resource |
| [aws_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/4.33.0/docs/resources/security_group) | resource |
| [aws_security_group_rule.jmx-exporter](https://registry.terraform.io/providers/hashicorp/aws/4.33.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.msk-plain](https://registry.terraform.io/providers/hashicorp/aws/4.33.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.msk-tls](https://registry.terraform.io/providers/hashicorp/aws/4.33.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.node_exporter](https://registry.terraform.io/providers/hashicorp/aws/4.33.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.zookeeper-plain](https://registry.terraform.io/providers/hashicorp/aws/4.33.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.zookeeper-tls](https://registry.terraform.io/providers/hashicorp/aws/4.33.0/docs/resources/security_group_rule) | resource |
| [aws_s3_bucket](https://registry.terraform.io/providers/hashicorp/aws/4.33.0/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_lifecycle_configuration](https://registry.terraform.io/providers/hashicorp/aws/4.33.0/docs/resources/s3_bucket_lifecycle_configuration) | resource |
| [aws_s3_bucket_acl](https://registry.terraform.io/providers/hashicorp/aws/4.33.0/docs/resources/s3_bucket_acl) | resource |
| [random_id.configuration](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [random_string.configuration](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [aws_availability_zones.azs](https://registry.terraform.io/providers/hashicorp/aws/4.33.0/docs/data-sources/availability_zones) | data source |
| [aws_subnet.subnet_az1](https://registry.terraform.io/providers/hashicorp/aws/4.33.0/docs/data-sources/subnet) | data source |
| [aws_subnet.subnet_az2](https://registry.terraform.io/providers/hashicorp/aws/4.33.0/docs/data-sources/subnet) | data source |
| [aws_subnet.subnet_az3](https://registry.terraform.io/providers/hashicorp/aws/4.33.0/docs/data-sources/subnet) | data source |
| [aws_vpc.vpc](https://registry.terraform.io/providers/hashicorp/aws/4.33.0/docs/data-sources/vpc) | data source |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.33.0 |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |


<!-- END_TF_DOCS -->
