# Authoritative. Sets the IAM policy for the service account and replaces any existing policy already attached.

# This controls who can use/manage the service account
resource "google_service_account_iam_policy" "iam_sa_policy" {
  service_account_id = var.service_account_name
  policy_data        = data.google_iam_policy.project_policy.policy_data
}

# This controls what the service account can access
resource "google_project_iam_policy" "project_policy" {
  project     = var.project_id
  policy_data = data.google_iam_policy.project_policy.policy_data
}

data "google_iam_policy" "project_policy" {
  dynamic "binding" {
    for_each = var.roles
    content {
      role = binding.value
      members = [
        "serviceAccount:${var.service_account_name}"
      ]
    }
  }
}
