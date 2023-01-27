
locals {
  server_properties = join("\n", [for k, v in local.server_properties_default : format("%s = %s", k, v)])
  server_properties_default = {
    "auto.create.topics.enable"      = var.auto_create_topics_enable
    "default.replication.factor"     = "3"
    "min.insync.replicas"            = "2"
    "num.io.threads"                 = "8"
    "num.network.threads"            = "5"
    "num.partitions"                 = "6"
    "num.replica.fetchers"           = "4"
    "unclean.leader.election.enable" = "true"
    "delete.topic.enable"            = var.delete_topic_enable
  }

  logs_enable = var.logs_enable ? 1 : 0
  service_set = var.set_name == null ? var.building_block : join("--", [var.building_block, var.set_name])
  name_random = join("-", [local.service_set, random_string.random.result])
}