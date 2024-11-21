output "network_self_link" {
  description = "VPC Self-link"
  value       = data.google_compute_network.default.name != null ? data.google_compute_network.default.self_link : google_compute_network.private[0].self_link
}

output "subnetwork_self_link" {
  description = "subnetwork self link"
  value       = data.google_compute_subnetwork.default.name != null ? data.google_compute_subnetwork.default.self_link : google_compute_subnetwork.private[0].self_link
}

output "network_name" {
  description = "VPC Name"
  value       = data.google_compute_network.default.name != null ? data.google_compute_network.default.name : google_compute_network.private[0].name
}

output "ip_cidr_range" {
  value = data.google_compute_subnetwork.default.name != null ? data.google_compute_subnetwork.default.ip_cidr_range : google_compute_subnetwork.private[0].ip_cidr_range
}

output "network_cidr_ranges" {
  description = "List of CIDR Blocks"
  value = compact([
    data.google_compute_subnetwork.default.name != null ?
    data.google_compute_subnetwork.default.ip_cidr_range :
    google_compute_subnetwork.private[0].ip_cidr_range,

    # Lógica similar para secondary ranges, se aplicável
    try(data.google_compute_subnetwork.default.secondary_ip_range[0].ip_cidr_range,
    google_compute_subnetwork.private[0].secondary_ip_range[0].ip_cidr_range),

    try(data.google_compute_subnetwork.default.secondary_ip_range[1].ip_cidr_range,
    google_compute_subnetwork.private[0].secondary_ip_range[1].ip_cidr_range)
  ])
}
