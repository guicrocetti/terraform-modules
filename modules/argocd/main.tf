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
  cluster_ca_certificate = base64decode(
    var.cluster_ca_certificate,
  )
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "gke-gcloud-auth-plugin"
  }
}

provider "helm" {
  kubernetes {
    host = "https://${var.cluster_endpoint}"
    cluster_ca_certificate = base64decode(
      var.cluster_ca_certificate,
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
  cluster_ca_certificate = base64decode(
    var.cluster_ca_certificate,
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


resource "kubectl_manifest" "argocd_namespace" {
  yaml_body  = <<YAML
apiVersion: v1
kind: Namespace
metadata:
  name: argocd
YAML
  apply_only = true
}

resource "helm_release" "argocd" {
  chart      = "argo-cd"
  name       = "argocd"
  namespace  = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  version    = "v7.7.3"

  values = [
    yamlencode({
      # domain = "${var.argo_domain}"

      certificate = {
        enabled = false
      }

      "argo-cd" = {
        "redis-ha" = {
          enabled = true
        }

        controller = {
          replicas = 1
        }

        # server = {
        #   extraArgs = ["--insecure"]
        #   replicas  = 2
        #   ingress = {
        #     enabled          = true
        #     ingressClassName = "nginx"
        #     annotations = {
        #       "nginx.ingress.kubernetes.io/force-ssl-redirect" = "true"
        #       "nginx.ingress.kubernetes.io/ssl-passthrough"    = "true"
        #     }
        #     tls = true
        #     config = {
        #       tls = {
        #         secretName = "argocd-server-tls"
        #       }
        #     }
        #   }
        # }

        repoServer = {
          replicas = 2
        }

        applicationSet = {
          replicas = 2
        }

        dex = {
          enabled = true
        }

        notifications = {
          enabled = true
        }
      }
    })
  ]

  dependency_update = true
  lifecycle {
    ignore_changes = all
  }

  atomic = true

  # depends_on = [
  #   kubectl_manifest.argocd_namespace,
  #   google_container_node_pool.general,
  #   helm_release.external_secrets,
  #   helm_release.ingress-nginx
  # ]
}

# resource "kubectl_manifest" "AppProject" {
#   yaml_body = templatefile("${path.module}/argocd/application.yaml", {
#     repo_username = var.git_repository_username
#     repo_name     = var.git_repository
#     cluster_name  = var.cluster_name
#   })

#   depends_on = [helm_release.argocd]

#   wait_for {
#     field {
#       key   = "status.sync.status"
#       value = "Synced"
#     }
#   }
# }
