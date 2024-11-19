# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED VARIABLES
# ---------------------------------------------------------------------------------------------------------------------

variable "project_id" {
  description = "project name"
  type        = string
}

variable "roles" {
  description = "['roles/iam.workloadIdentityUser']"
  type        = list(string)
}

variable "member" {
  description = "'serviceAccount:service_account_email' or 'user:user1@company.com' or 'group:team@company.com'"
  type        = string
}
