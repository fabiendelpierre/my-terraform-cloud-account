terraform {
  required_version = ">= 1.0.0"

  required_providers {
    provider = {
      source  = "hashicorp/random"
      version = ">= 3.0.0"
    }
  }
}