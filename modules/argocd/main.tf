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
    kubectl = {
      source  = "alekc/kubectl"
      version = "~> 2.0.4"
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

provider "kubectl" {
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

resource "kubernetes_secret" "argocd_repo_secret" {
  depends_on = [helm_release.argocd]

  metadata {
    name      = "private-repo"
    namespace = "argocd"
    labels = {
      "argocd.argoproj.io/secret-type" = "repository"
    }
  }

  data = {
    type     = "git"
    url      = "https://github.com/${var.repository_name}.git"
    username = var.repo_username
    password = var.argocd_repo_token
  }
}

resource "null_resource" "git_clone_and_apply" {
  depends_on = [helm_release.argocd, kubernetes_secret.argocd_repo_secret]

  provisioner "local-exec" {
    command = <<-EOT
      # Clone the private repository using the provided token
      git clone https://${var.argocd_repo_token}@github.com/${var.repository_name}.git /tmp/argocd-config
      
      # Wait for ArgoCD to be ready
      kubectl wait --for=condition=available --timeout=300s deployment/argocd-server -n argocd
      
      # Apply the kustomization
      kubectl apply -k /tmp/argocd-config/argocd
      
      # Cleanup
      rm -rf /tmp/argocd-config
    EOT
  }
}
