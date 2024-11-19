# Non-authoritative. Updates the IAM policy to grant a role to a new member.
# Other members for the role for the service account are preserved.

# Adds individual permissions to a service account
# Doesn't affect existing permissions
# Great for gradually adding permissions
# Example: "Let's give this new team access to use our service account"

resource "google_service_account_iam_member" "iam_sa_member" {
  service_account_id = "projects/${var.project_id}/serviceAccounts/${var.service_account_email}"
  for_each           = toset(var.roles)
  role               = each.key
  member             = var.member
}
