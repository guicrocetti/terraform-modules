# ---------------------------------------------------------------------------------------------------------------------
# Enable APIs services
# ---------------------------------------------------------------------------------------------------------------------

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project_service
resource "google_project_service" "compute" {
  service            = "compute.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "container" {
  service            = "container.googleapis.com"
  disable_on_destroy = false
}

# ---------------------------------------------------------------------------------------------------------------------
# Try to get the existing VPC
# ---------------------------------------------------------------------------------------------------------------------

data "google_compute_network" "default" {
  count   = !var.create_vpc ? 1 : 0
  name    = var.network_name
  project = var.project_id
}

data "google_compute_subnetwork" "default" {
  count  = !var.create_vpc ? 1 : 0
  name   = var.subnetwork_name
  region = var.region
}

# ---------------------------------------------------------------------------------------------------------------------
# Conditional: If the VPC exists, use it; otherwise, create a new one
# ---------------------------------------------------------------------------------------------------------------------

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network
resource "google_compute_network" "private" {
  count                           = var.create_vpc ? 1 : 0
  name                            = var.network_name
  routing_mode                    = "REGIONAL"
  auto_create_subnetworks         = false
  mtu                             = 1460
  delete_default_routes_on_create = false

}


# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork
resource "google_compute_subnetwork" "private" {
  count                    = var.create_vpc ? 1 : 0
  name                     = var.subnetwork_name
  ip_cidr_range            = var.cidr_range
  region                   = var.region
  network                  = google_compute_network.private[0].id
  private_ip_google_access = true

  secondary_ip_range {
    range_name    = "k8s-pod-range"
    ip_cidr_range = var.k8s_pod_range
  }
  secondary_ip_range {
    range_name    = "k8s-service-range"
    ip_cidr_range = var.k8s_service_range
  }

  lifecycle {
    ignore_changes = [secondary_ip_range]
  }
}
