# Authoritative. Sets the IAM policy for the service account and replaces any existing policy already attached.

resource "google_service_account_iam_policy" "iam_sa_policy" {
  service_account_id = "projects/${var.project_id}/serviceAccounts/${var.service_account_email}"
  for_each           = toset(var.roles)
  policy_data        = each.key
}