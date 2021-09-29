variable "github_personal_token" {
  description = "GitHub personal token to authenticate to GitHub API and manage my account"
  # Set in Terraform Cloud via sensitive variable
  type      = string
  sensitive = true
}

variable "tfe_personal_token" {
  description = "TFC personal token to manage TFC API and manage my account"
  # Set in Terraform Cloud via sensitive variable
  type      = string
  sensitive = true
}

variable "tfe_team_token" {
  description = "TFC team token to manage modules in the module registry"
  # Set in Terraform Cloud via sensitive variable
  type      = string
  sensitive = true
}