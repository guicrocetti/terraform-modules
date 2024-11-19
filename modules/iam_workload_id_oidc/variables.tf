# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED VARIABLES
# ---------------------------------------------------------------------------------------------------------------------
variable "pool_provider_id" {
  description = "pool provider id name"
  type        = string
}

variable "pool_id" {
  description = "pool id name"
  type        = string
}

variable "attribute_condition" {
  description = "attribute condition"
  type        = string
  default     = "attribute.actor.equals('google.subject')"
}

variable "mapping_attributes" {
  description = "atributes to be mapped"
  type        = map(string)
  default = {
    "google.subject"       = "assertion.sub"
    "attribute.actor"      = "assertion.actor"
    "attribute.repository" = "assertion.repository"
  }
}

variable "oidc_issuer" {
  description = "issuer of the OpenID Connect provider"
  type        = string
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL VARIABLES
# ---------------------------------------------------------------------------------------------------------------------

variable "pool_display_name" {
  description = "pool display name"
  type        = string
  default     = "${var.pool_id} Pool"
}

variable "pool_description" {
  description = "pool description"
  type        = string
  default     = "Identity pool for ${var.pool_id}"
}

variable "pool_providrr_display_name" {
  description = "Pool provider display name"
  type        = string
  default     = "${var.pool_provider_id} Provider"
}
