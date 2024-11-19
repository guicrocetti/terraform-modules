# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED VARIABLES
# ---------------------------------------------------------------------------------------------------------------------

variable "project_id" {
  type        = string
  description = "The project name"
}

variable "name" {
  type        = string
  description = "The name of the service account"
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL VARIABLES
# ---------------------------------------------------------------------------------------------------------------------

variable "display_name" {
  type        = string
  description = "The name to be displayed"
  default     = "service account ${var.name}"
}

variable "description" {
  type        = string
  description = "description of the service account"
  default     = "service account ${var.name}"
}
