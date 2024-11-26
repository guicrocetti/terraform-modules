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
  description = "['roles/iam.workloadIdentityUser',]"
  type        = list(string)
}
