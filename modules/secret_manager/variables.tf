variable "cluster_name" {
  description = "output of module cluster -> cluster_name"
  type        = string
}

variable "cluster_server" {
  description = "output of module cluster -> cluster_server"
  type        = string
}

variable "cluster_ca_data" {
  description = "output of module cluster -> cluster_ca_data"
  type        = string
}

variable "secret_name" {
  description = "Name of the secret to be stored in secret manager"
  type        = string
  default     = "default_cluster_secret_data"
}

variable "label" {
  description = "optional secret manager label"
  type        = string
  default     = "cluster_secret_data"
}
