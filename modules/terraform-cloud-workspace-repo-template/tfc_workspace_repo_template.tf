resource "github_repository" "main" {
  name        = "terraform-cloud-workspace-repo-template"
  description = "A template for Terraform Cloud workspace repositories"
  visibility  = "public"

  auto_init   = true
  is_template = true

  has_issues   = true
  has_projects = false
  has_wiki     = false

  gitignore_template = "Terraform"
  license_template   = "unlicense"
}

resource "github_repository_file" "readme" {
  repository = github_repository.main.name
  branch     = github_repository.main.default_branch
  file       = "README.md"

  commit_message = "README template"
  commit_author  = "Terraform Cloud"
  commit_email   = "fabiend@app.terraform.io"

  overwrite_on_create = true

  content = templatefile("${path.module}/readme.md.tpl", {})
}

resource "github_repository_file" "github_action" {
  repository = github_repository.main.name
  branch     = github_repository.main.default_branch
  file       = ".github/workflows/terraform.yml"

  commit_message = "Set up GitHub action"
  commit_author  = "Terraform Cloud"
  commit_email   = "fabiend@app.terraform.io"

  overwrite_on_create = true

  content = templatefile("${path.module}/github_actions.yml.tpl", {})
}

resource "github_repository_file" "pre_commit_config" {
  repository = github_repository.main.name
  branch     = github_repository.main.default_branch
  file       = ".pre-commit-config.yaml"

  commit_message = "Set up Git pre-commit hook config"
  commit_author  = "Terraform Cloud"
  commit_email   = "fabiend@app.terraform.io"

  overwrite_on_create = true

  content = templatefile("${path.module}/pre_commit_config.yaml.tpl", {
    pre_commit_config_repo    = "git://github.com/antonbabenko/pre-commit-terraform"
    pre_commit_config_version = "v1.51.0"
  })
}

resource "github_repository_file" "checkov_config" {
  repository = github_repository.main.name
  branch     = github_repository.main.default_branch
  file       = ".checkov.yml"

  commit_message = "Set up Checkov config file"
  commit_author  = "Terraform Cloud"
  commit_email   = "fabiend@app.terraform.io"

  overwrite_on_create = true

  content = templatefile("${path.module}/checkov.yml.tpl", {
    pre_commit_config_repo    = "git://github.com/antonbabenko/pre-commit-terraform"
    pre_commit_config_version = "v1.51.0"
  })
}

resource "github_repository_file" "main_tf" {
  repository = github_repository.main.name
  branch     = github_repository.main.default_branch
  file       = "main.tf"

  commit_message = "Write placeholder main.tf"
  commit_author  = "Terraform Cloud"
  commit_email   = "fabiend@app.terraform.io"

  overwrite_on_create = true

  content = templatefile("${path.module}/main.tf.tpl", {})
}

resource "github_repository_file" "providers_tf" {
  repository = github_repository.main.name
  branch     = github_repository.main.default_branch
  file       = "providers.tf"

  commit_message = "Write placeholder providers.tf"
  commit_author  = "Terraform Cloud"
  commit_email   = "fabiend@app.terraform.io"

  overwrite_on_create = true

  content = templatefile("${path.module}/providers.tf.tpl", {})
}

resource "github_repository_file" "variables_tf" {
  repository = github_repository.main.name
  branch     = github_repository.main.default_branch
  file       = "variables.tf"

  commit_message = "Write placeholder variables.tf"
  commit_author  = "Terraform Cloud"
  commit_email   = "fabiend@app.terraform.io"

  overwrite_on_create = true

  content = templatefile("${path.module}/variables.tf.tpl", {})
}