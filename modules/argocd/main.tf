# ---------------------------------------------------------------------------------------------------------------------
# PROVIDER CONFIGURATION
# ---------------------------------------------------------------------------------------------------------------------

terraform {
  required_version = ">= 1.1"

  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.31.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.14.0"
    }
  }
}

data "google_client_config" "provider" {}

provider "kubernetes" {
  host  = "https://${var.cluster_endpoint}"
  token = data.google_client_config.provider.access_token
  cluster_ca_certificate = try(
    base64decode(var.cluster_ca_certificate),
    null
  )
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "gke-gcloud-auth-plugin"
  }
}

provider "helm" {
  kubernetes {
    host = "https://${var.cluster_endpoint}"
    cluster_ca_certificate = try(
      base64decode(var.cluster_ca_certificate),
      null
    )
    token = data.google_client_config.provider.access_token
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "gke-gcloud-auth-plugin"
    }
  }
}


# ---------------------------------------------------------------------------------------------------------------------
# DEPLOY ARGOCD
# ---------------------------------------------------------------------------------------------------------------------

resource "helm_release" "argocd" {
  chart            = "argo-cd"
  name             = "argocd"
  namespace        = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  version          = "v7.7.3"
  create_namespace = true

  dependency_update = true
  lifecycle {
    ignore_changes = all
  }

  atomic = false
}
