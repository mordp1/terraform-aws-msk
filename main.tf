# Module: aws_messaging_msk
# Description Terraform module to provision msk messaging in aws

resource "aws_msk_configuration" "this" {
  kafka_versions    = [var.kafka_version]
  name              = local.name_random
  description       = "Created by Terraform ${local.name_random}"
  server_properties = random_id.configuration.keepers.server_properties
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_msk_cluster" "msk" {
  depends_on             = [aws_msk_configuration.this]
  cluster_name           = local.name_random
  kafka_version          = var.kafka_version
  number_of_broker_nodes = var.number_of_broker_nodes

  broker_node_group_info {
    instance_type = var.instance_type
    client_subnets = [
      data.aws_subnet.subnet_az1.id,
      data.aws_subnet.subnet_az2.id,
      data.aws_subnet.subnet_az3.id,
    ]
    storage_info {
      ebs_storage_info {
        volume_size = var.volume_size
      }
    }

    security_groups = concat(aws_security_group.this.*.id, var.security_groups_names)
  }
  client_authentication {
    unauthenticated = var.client_authentication_unauthenticated_enabled
  }

  encryption_info {

    encryption_in_transit {
      client_broker = var.encryption_in_transit_client_broker
      in_cluster    = var.encryption_in_transit_in_cluster
    }
  }

  configuration_info {
    arn      = aws_msk_configuration.this.arn
    revision = aws_msk_configuration.this.latest_revision
  }
  open_monitoring {
    prometheus {
      jmx_exporter {
        enabled_in_broker = var.prometheus_jmx_exporter
      }
      node_exporter {
        enabled_in_broker = var.prometheus_node_exporter
      }
    }
  }
  dynamic "logging_info" {
    for_each = var.logs_enable == true ? [1] : []
    content {
      broker_logs {
        dynamic "cloudwatch_logs" {
          for_each = aws_cloudwatch_log_group.msk-cluster[0].name != "" ? ["true"] : []
          content {
            enabled   = true
            log_group = aws_cloudwatch_log_group.msk-cluster[0].name
          }
        }
        dynamic "s3" {
          for_each = aws_s3_bucket.bucket[0].id != "" ? ["true"] : []
          content {
            enabled = true
            bucket  = aws_s3_bucket.bucket[0].id
            prefix  = var.s3_logs_prefix
          }
        }
      }
    }
  }
  tags = var.tags
}

resource "aws_security_group" "this" {
  name_prefix = "${local.name_random}-"
  vpc_id      = data.aws_vpc.vpc.id
  tags        = var.tags
  description = "Created by Terraform ${local.name_random}"

}

resource "aws_security_group_rule" "msk-plain" {
  from_port         = 9092
  to_port           = 9092
  protocol          = "tcp"
  security_group_id = aws_security_group.this.id
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "msk-tls" {
  from_port         = 9094
  to_port           = 9094
  protocol          = "tcp"
  security_group_id = aws_security_group.this.id
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "zookeeper-plain" {
  from_port         = 2181
  to_port           = 2181
  protocol          = "tcp"
  security_group_id = aws_security_group.this.id
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "zookeeper-tls" {
  from_port         = 2182
  to_port           = 2182
  protocol          = "tcp"
  security_group_id = aws_security_group.this.id
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "jmx-exporter" {
  count = var.prometheus_jmx_exporter ? 1 : 0

  from_port         = 11001
  to_port           = 11001
  protocol          = "tcp"
  security_group_id = aws_security_group.this.id
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "node_exporter" {
  count = var.prometheus_node_exporter ? 1 : 0

  from_port         = 11002
  to_port           = 11002
  protocol          = "tcp"
  security_group_id = aws_security_group.this.id
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_s3_bucket" "bucket" {
  count         = local.logs_enable
  bucket        = local.name_random
  force_destroy = true
  tags          = var.tags
}

resource "aws_s3_bucket_lifecycle_configuration" "this" {
  count      = local.logs_enable
  depends_on = [aws_s3_bucket.bucket]
  bucket     = aws_s3_bucket.bucket[0].bucket
  rule {
    status = "Enabled"
    expiration {
      days = 365
    }
    id = var.building_block
  }
}

resource "aws_s3_bucket_acl" "bucket_acl" {
  count  = local.logs_enable
  bucket = aws_s3_bucket.bucket[0].id
  acl    = "private"
}

resource "aws_cloudwatch_log_group" "msk-cluster" {
  count = local.logs_enable
  name  = local.name_random
  tags  = var.tags
}

resource "random_id" "configuration" {
  prefix      = "${var.building_block}-"
  byte_length = 2

  keepers = {
    server_properties = local.server_properties
  }
}

resource "random_string" "random" {
  length  = 6
  special = false
  upper   = false
}
