variable "project_id" {
  description = "The ID of the project where the networks exist."
  type        = string
}

variable "peer_network_self_link1" {
  description = "output of module network -> network_self_link"
  type        = string
}

variable "peer_network_self_link2" {
  description = "output of module network -> network_self_link"
  type        = string
}

variable "peer_network_name_1" {
  description = "output of module network -> network_name"
  type        = string
}

variable "peer_network_name_2" {
  description = "output of module network -> network_name"
  type        = string
}
