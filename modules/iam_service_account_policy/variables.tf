# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED VARIABLES
# ---------------------------------------------------------------------------------------------------------------------

variable "project_id" {
  description = "project name"
  type        = string
}

variable "service_account_name" {
  description = "service account name"
  type        = string
}

variable "roles" {
  type        = list(string)
  description = "List of roles to assign to the service account"
}
