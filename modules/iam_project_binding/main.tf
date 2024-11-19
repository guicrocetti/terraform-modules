# Authoritative for a given role. Updates the IAM policy to grant a role to a list of members. 
# Other roles within the IAM policy for the project are preserved.

# It completely controls who has access to that role
# If you define members A and B for a role, and member C had that role before, member C will lose access
# It's like replacing the entire list of members for a role


resource "google_project_iam_binding" "iam_project_binding" {
  project  = var.project_id
  for_each = toset(var.roles)
  role     = each.key
  members  = var.members
}
