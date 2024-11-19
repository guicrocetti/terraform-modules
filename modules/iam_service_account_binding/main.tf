# Authoritative for a given role. Updates the IAM policy to grant a role to a list of members. 
# Other roles within the IAM policy for the service account are preserved.

# Controls ALL permissions for a specific role on a service account
# Replaces entire list of members when you make changes
# Use when you want to strictly control who can use/manage a service account
# Example: "Only these 3 teams can act as this service account"

resource "google_service_account_iam_binding" "iam_sa_binding" {
  service_account_id = "projects/${var.project_id}/serviceAccounts/${var.service_account_email}"
  for_each           = toset(var.roles)
  role               = each.key
  members            = var.members
}
