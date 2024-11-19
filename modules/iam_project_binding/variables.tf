# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED VARIABLES
# ---------------------------------------------------------------------------------------------------------------------

variable "project_id" {
  description = "project name"
  type        = string
}

variable "roles" {
  description = "['roles/iam.workloadIdentityUser',]"
  type        = list(string)
}

variable "members" {
  description = "['serviceAccount:sa_email', 'user:user1@company.com', 'group:team@company.com'],"
  type        = list(string)
}
