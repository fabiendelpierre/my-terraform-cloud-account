resource "tfe_registry_module" "github_tfc_registry_module" {
  provider = tfe.module_registry

  vcs_repo {
    display_identifier = "fabiendelpierre/terraform-github-tfc-registry-module"
    identifier         = "fabiendelpierre/terraform-github-tfc-registry-module"
    oauth_token_id     = data.tfe_oauth_client.default_oauth_client.oauth_token_id
  }
}