output "workload_identity_pool_id" {
  value = google_iam_workload_identity_pool.workload_pool.workload_identity_pool_id
}

output "pool_id" {
  value = google_iam_workload_identity_pool.workload_pool.id
}


output "workload_identity_pool__provider_id" {
  value = google_iam_workload_identity_pool_provider.workload_provider.workload_identity_pool_provider_id
}

output "provider_id" {
  value = google_iam_workload_identity_pool_provider.workload_provider.id
}
