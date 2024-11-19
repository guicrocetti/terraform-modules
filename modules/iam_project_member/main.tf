# Non-authoritative. Updates the IAM policy to grant a role to a new member. 
# Other members for the role for the project are preserved.

# Manages individual member-role pairs
# Adding/removing members doesn't affect other existing members
# Works like: "add this person to this role" without touching other permissions

resource "google_project_iam_member" "iam_project_mamber" {
  project  = var.project_id
  for_each = toset(var.roles)
  role     = each.key
  member   = var.member
}
