# Module: aws_messaging_msk
# Input variables: Let you customize aspects of Terraform modules without altering the module's own source code.
#                  This functionality allows you to share modules across different Terraform configurations,
#                  making your module composable and reusable.
variable "auto_create_topics_enable" {
  description = "A config for Kafka server.properties"
  type        = bool
  default     = false

}

variable "building_block" {
  description = "Building Block"
  type        = string
}

variable "client_authentication_unauthenticated_enabled" {
  description = "Enables unauthenticated access."
  type        = bool
  default     = true
}

variable "cloudwatch_logs_group" {
  description = "Name of the Cloudwatch Log Group to deliver logs to."
  type        = string
  default     = ""
}

variable "delete_topic_enable" {
  description = "A config for Kafka server.properties"
  type        = bool
  default     = false

}

variable "encryption_in_transit_client_broker" {
  description = "Encryption setting for data in transit between clients and brokers. Valid values: TLS, TLS_PLAINTEXT, and PLAINTEXT. Default value is TLS_PLAINTEXT."
  type        = string
  default     = "TLS_PLAINTEXT"
  validation {
    condition = anytrue([
      var.encryption_in_transit_client_broker == "TLS_PLAINTEXT",
      var.encryption_in_transit_client_broker == "TLS",
      var.encryption_in_transit_client_broker == "PLAINTEXT"
    ])
    error_message = "Kafka encryption type must be a valid AWS Kafka encryption type. Valid values: TLS, TLS_PLAINTEXT, and PLAINTEXT."
  }
}

variable "encryption_in_transit_in_cluster" {
  description = "Whether data communication among broker nodes is encrypted. Default value: true."
  type        = bool
  default     = false
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "iac"
}

variable "env_business" {
  description = "The business name"
  type        = string
  default     = "XPTO"
}

variable "enhanced_monitoring" {
  description = "Specify the desired enhanced MSK CloudWatch monitoring level to one of three monitoring levels: DEFAULT, PER_BROKER, PER_TOPIC_PER_BROKER or PER_TOPIC_PER_PARTITION. See [Monitoring Amazon MSK with Amazon CloudWatch](https://docs.aws.amazon.com/msk/latest/developerguide/monitoring.html)."
  type        = string
  default     = "DEFAULT"
}

variable "kafka_version" {
  description = "Specify the desired Kafka software version."
  type        = string
  default     = "3.2.0"
  validation {
    condition = anytrue([
      var.kafka_version == "2.6.2",
      var.kafka_version == "2.8.2",
      var.kafka_version == "3.2.0",
      var.kafka_version == "2.6.3"
    ])
    error_message = "Kafka software version must be a valid AWS Version. Valid values: 2.6.2, 2.6.3, 2.8.2, and 3.2.0."
  }
}

variable "instance_type" {
  description = "Specify the instance type to use for the kafka brokers. e.g. kafka.m5.large."
  type        = string
  default     = "kafka.t3.small"
  validation {
    condition = anytrue([
      var.instance_type == "kafka.t3.small",
      var.instance_type == "kafka.m5.large",
      var.instance_type == "kafka.m5.xlarge",
      var.instance_type == "kafka.m5.2xlarge",
      var.instance_type == "kafka.m5.4xlarge"
    ])
    error_message = "Kafka instance type must be a valid AWS Kafka instance type."
  }
}

variable "logs_enable" {
  description = "To enable the creation of an S3 Bucket to save the logs"
  type        = bool
  default     = false

}

variable "number_of_broker_nodes" {
  description = "The desired total number of broker nodes in the kafka cluster. It must be a multiple of the number of specified client subnets."
  type        = number
}

//variable "parameters" {
//  description = "Parameters to include in the DB parameter group"
//  type        = list(map(string))
//  default     = []
//}

variable "profile" {
  description = "AWS Profile name"
  type        = string
  default     = "iacaws"
}

variable "region" {
  description = "AWS Region name"
  type        = string
  default     = "eu-west-1"
}

variable "volume_size" {
  description = "The size in GiB of the EBS volume for the data drive on each broker node."
  type        = number
  default     = 100
}

variable "prometheus_jmx_exporter" {
  description = "Indicates whether you want to enable or disable the JMX Exporter."
  type        = bool
  default     = false
}

variable "prometheus_node_exporter" {
  description = "Indicates whether you want to enable or disable the Node Exporter."
  type        = bool
  default     = false
}

variable "security_groups_names" {
  description = "A list of extra security groups to associate with the elastic network interfaces to control who can communicate with the cluster."
  type        = list(string)
  default     = []
}

variable "subnet" {
  description = "A tag Name of subnets to find and connect to in client VPC"
  type        = string
  default     = "private"
}

variable "set_name" {
  description = "Service set"
  type        = string
  default     = null
}

variable "s3_logs_bucket" {
  description = "Name of the S3 bucket to deliver logs to."
  type        = string
  default     = ""
}

variable "s3_logs_prefix" {
  description = "Prefix to append to the folder name."
  type        = string
  default     = ""
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}