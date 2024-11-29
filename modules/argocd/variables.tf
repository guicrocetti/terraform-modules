variable "project_id" {
  description = "project id name"
  type        = string
}

variable "region" {
  description = "project region"
  type        = string
}

variable "cluster_endpoint" {
  description = "endpoint of gcp cluster"
  type        = string
}

variable "cluster_ca_certificate" {
  description = "cluster certificate"
  type        = string
}

variable "argocd_repo_token" {
  description = "token to access the argocd repository"
  type        = string
}

variable "repository_name" {
  description = "argocd repository name user/name"
  type        = string
}

variable "repo_username" {
  description = "username for the argocd repository"
  type        = string
}

# variable "argo_domain" {
#   description = "ArgoCD domain name"
#   type        = string
# }
