terraform {
  required_version = "~> 1.0"

  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 4.1"
    }
    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.26"
    }
  }

  backend "remote" {
    organization = "fabiend"

    workspaces {
      name = "my-terraform-cloud-account"
    }
  }
}

provider "github" {
  token = var.github_personal_token
}

provider "tfe" {
  token = var.tfe_personal_token
}

provider "tfe" {
  alias = "module_registry"
  token = var.tfe_team_token
}

data "tfe_workspace" "my_terraform_cloud_account" {
  name         = "my-terraform-cloud-account"
  organization = "fabiend"
}

data "tfe_oauth_client" "default_oauth_client" {
  oauth_client_id = "oc-qmTmbHDrux9Su4uG"
}