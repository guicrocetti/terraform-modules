# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED VARIABLES
# ---------------------------------------------------------------------------------------------------------------------

variable "project_id" {
  description = "project name"
  type        = string
}

variable "service_account_email" {
  description = "service account email"
  type        = string
}

variable "roles" {
  description = "['roles/iam.workloadIdentityUser',]"
  type        = list(string)
}
