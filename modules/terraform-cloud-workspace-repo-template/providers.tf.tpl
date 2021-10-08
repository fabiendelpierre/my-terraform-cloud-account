terraform {
  required_version = "~> 1.0"

  required_providers {
    provider = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }

  backend "remote" {
    organization = "organization_name"

    workspaces {
      name = "workspace_name"
    }
  }
}