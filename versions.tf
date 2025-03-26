
terraform {
  required_providers {
    aws = {
      version = ">= 4.36.0, < 6.0.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.9.0"
    }
  }
}
