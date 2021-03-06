# This module sets up a blank GitHub repo (using a template or not) and imports
# it into the TFC private registry, but it needed to be set up "manually"
# first.
resource "tfe_registry_module" "github_tfc_registry_module" {
  provider = tfe.module_registry

  vcs_repo {
    display_identifier = "fabiendelpierre/terraform-github-tfc-registry-module"
    identifier         = "fabiendelpierre/terraform-github-tfc-registry-module"
    oauth_token_id     = data.tfe_oauth_client.default_oauth_client.oauth_token_id
  }
}

resource "tfe_registry_module" "github_tfc_workspace_module" {
  provider = tfe.module_registry

  vcs_repo {
    display_identifier = "fabiendelpierre/terraform-github-tfc-workspace-module"
    identifier         = "fabiendelpierre/terraform-github-tfc-workspace-module"
    oauth_token_id     = data.tfe_oauth_client.default_oauth_client.oauth_token_id
  }
}

# The next modules below use the one that was provisioned "manually" above to
# set up GitHub repos for reusable modules and import them into TFC
# automatically.
module "azurerm_virtual_network" {
  depends_on = [module.terraform-module-repo-template]

  source  = "app.terraform.io/fabiend/tfc-registry-module/github"
  version = "0.1.0"

  github_repo_name        = "terraform-azurerm-virtual-network"
  github_repo_description = "A simple module to create a virtual network in Azure with one subnet and a standard route table"

  github_repo_use_template        = true
  github_repo_template_owner_name = local.default_github_org
  github_repo_template_repo_name  = local.tf_module_template_repo
  oauth_token_id                  = data.tfe_oauth_client.default_oauth_client.oauth_token_id
}

module "azurerm_key_vault" {
  depends_on = [module.terraform-module-repo-template]

  source  = "app.terraform.io/fabiend/tfc-registry-module/github"
  version = "0.1.0"

  github_repo_name        = "terraform-azurerm-key-vault"
  github_repo_description = "A simple module to create an instance of Azure Key Vault"

  github_repo_use_template        = true
  github_repo_template_owner_name = local.default_github_org
  github_repo_template_repo_name  = local.tf_module_template_repo
  oauth_token_id                  = data.tfe_oauth_client.default_oauth_client.oauth_token_id
}