module "azure_msdn_vnet" {
  source  = "app.terraform.io/fabiend/tfc-workspace-module/github"
  version = "0.2.0"

  github_repo_name        = "tfc-workspace-azure-msdn-vnet"
  github_repo_description = "TF Cloud workspace that manages my virtual network in Azure"

  github_repo_use_template        = true
  github_repo_template_owner_name = local.default_github_org
  github_repo_template_repo_name  = local.tfc_workspace_template_repo

  tfc_workspace_name              = "azure-msdn-vnet"
  tfc_organization_name           = local.default_tfc_org
  tfc_workspace_terraform_version = local.global_tf_version

  tfc_workspace_tags = [
    "azure",
    "msdn",
    "network",
  ]
}