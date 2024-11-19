# Create a workload identity pool
resource "google_iam_workload_identity_pool" "workload_pool" {
  workload_identity_pool_id = var.pool_id
  display_name              = var.pool_display_name
  description               = var.pool_description
}

# Create oidc provider
resource "google_iam_workload_identity_pool_provider" "workload_provider" {
  workload_identity_pool_id          = google_iam_workload_identity_pool.workload_pool.workload_identity_pool_id
  workload_identity_pool_provider_id = var.pool_provider_id
  display_name                       = var.pool_providrr_display_name

  attribute_condition = var.attribute_condition

  attribute_mapping = var.mapping_attributes

  oidc {
    issuer_uri = var.oidc_issuer
  }
}
