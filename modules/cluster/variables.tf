# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED VARIABLES
# ---------------------------------------------------------------------------------------------------------------------

variable "region" {
  description = "The region in which to create the resources."
  type        = string
}

variable "zone" {
  description = "zone in which to create the resources."
  type        = string
}

variable "project_id" {
  description = "The ID of the project in which to create the resources."
  type        = string
}

variable "cluster_name" {
  description = "name of the cluster in which to create the resources"
  type        = string
  sensitive   = false
}

variable "service_account_email" {
  description = "service account email address that will be used to create node poools"
  type        = string
}
# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL VARIABLES
# ---------------------------------------------------------------------------------------------------------------------


variable "node_count" {
  description = "number of nodes in the cluster"
  default     = 3
  type        = number
}

variable "machine_type" {
  description = "Node Instance machine type"
  default     = "n1-standard-2"
  type        = string
}

variable "node_label" {
  default = "terraform-node-pool"
  type    = string
}

variable "remove_default_node_pool" {
  description = "if true, the default node pool will be removed from the cluster"
  default     = true
  type        = string
}

variable "initial_node_count" {
  description = "value of initial_node_count. default 1 if remove_default_node_pool is true"
  default     = 1
  type        = number
}

variable "deletion_protection" {
  description = "if true, deletion of the cluster will be protected"
  default     = false
  type        = bool
}

variable "network_self_link" {
  description = "self link of the network"
  type        = string
}

variable "subnetwork_self_link" {
  description = "self link of the subnet"
  type        = string
}

# Auto_upgrade must be true when release_channel REGULAR is set.
