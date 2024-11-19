output "sa_email" {
  value = google_service_account.service_account_name.email
}

output "sa_name" {
  value = google_service_account.service_account_name.name
}
