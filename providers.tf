terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.4.0"
      #configuration_aliases = [ producer_service ]
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = ">= 5.4.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.29"
    }
  }
}

provider "google" {
  project = var.gcp_project_id
  region  = var.gcp_target_region
}

provider "google-beta" {
  project = var.gcp_project_id
  region  = var.gcp_target_region
}

provider "google" {
  project = var.producer_gcp_project_id
  region  = var.producer_gcp_region
  alias   = "producer_service"
}

# Configure kubernetes provider with Oauth2 access token.
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/client_config
# This fetches a new token, which will expire in 1 hour.

provider "kubernetes" {
 
  host  = "https://${module.producer_service.endpoint}"
  token = module.producer_service.access_token
  cluster_ca_certificate = base64decode(
    module.producer_service.cluster_certificate,
  )
}
