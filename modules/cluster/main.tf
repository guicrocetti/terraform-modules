locals {
  network    = coalesce(var.network_self_link, "projects/${var.project_id}/global/networks/default")
  subnetwork = coalesce(var.subnetwork_self_link, "projects/${var.project_id}/regions/${var.region}/subnetworks/default")
}


# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster
resource "google_container_cluster" "primary" {
  name                     = var.cluster_name
  location                 = var.zone
  remove_default_node_pool = var.remove_default_node_pool
  initial_node_count       = var.initial_node_count
  network                  = local.network
  subnetwork               = local.subnetwork
  deletion_protection      = var.deletion_protection

  release_channel {
    channel = "REGULAR"
  }

  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }

  private_cluster_config {
    enable_private_nodes    = false
    enable_private_endpoint = false
  }
}

# REMOVED THE CREATION OF A NEW SERVICE ACCOUNT HERE, AND NOW IT WILL HAVE TO BE CREATE SEPARATED ON TERRAGRUNT 
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_service_account
# resource "google_service_account" "cluster" {
#   account_id = var.service_account
# }

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_node_pool
resource "google_container_node_pool" "general" {
  name       = "pool-${var.cluster_name}"
  cluster    = google_container_cluster.primary.id
  node_count = var.node_count
  network_config {
    enable_private_nodes = false # Whether nodes have internal IP addresses only.
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  node_config {
    machine_type = var.machine_type

    labels = {
      role = var.node_label
    }

    service_account = var.service_account_email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}
