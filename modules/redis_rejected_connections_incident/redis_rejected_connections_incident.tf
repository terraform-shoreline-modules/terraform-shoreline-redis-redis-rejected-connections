resource "shoreline_notebook" "redis_rejected_connections_incident" {
  name       = "redis_rejected_connections_incident"
  data       = file("${path.module}/data/redis_rejected_connections_incident.json")
  depends_on = [shoreline_action.invoke_firewall_port_opening,shoreline_action.invoke_redis_config_tuning]
}

resource "shoreline_file" "firewall_port_opening" {
  name             = "firewall_port_opening"
  input_file       = "${path.module}/data/firewall_port_opening.sh"
  md5              = filemd5("${path.module}/data/firewall_port_opening.sh")
  description      = "Update the firewall rules and open ports"
  destination_path = "/agent/scripts/firewall_port_opening.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_file" "redis_config_tuning" {
  name             = "redis_config_tuning"
  input_file       = "${path.module}/data/redis_config_tuning.sh"
  md5              = filemd5("${path.module}/data/redis_config_tuning.sh")
  description      = "Optimizing Redis configuration settings such as increasing the max number of connections or tuning the eviction policies to avoid overload."
  destination_path = "/agent/scripts/redis_config_tuning.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_firewall_port_opening" {
  name        = "invoke_firewall_port_opening"
  description = "Update the firewall rules and open ports"
  command     = "`chmod +x /agent/scripts/firewall_port_opening.sh && /agent/scripts/firewall_port_opening.sh`"
  params      = []
  file_deps   = ["firewall_port_opening"]
  enabled     = true
  depends_on  = [shoreline_file.firewall_port_opening]
}

resource "shoreline_action" "invoke_redis_config_tuning" {
  name        = "invoke_redis_config_tuning"
  description = "Optimizing Redis configuration settings such as increasing the max number of connections or tuning the eviction policies to avoid overload."
  command     = "`chmod +x /agent/scripts/redis_config_tuning.sh && /agent/scripts/redis_config_tuning.sh`"
  params      = ["PATH_TO_REDIS_CONF"]
  file_deps   = ["redis_config_tuning"]
  enabled     = true
  depends_on  = [shoreline_file.redis_config_tuning]
}

