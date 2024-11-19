resource "google_service_account" "service_account_name" {
  account_id   = var.name
  display_name = var.display_name
  description  = var.description
  project      = var.project_id
}
