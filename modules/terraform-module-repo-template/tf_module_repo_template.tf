resource "github_repository" "tf_module_repo_template" {
  name        = "terraform-module-repo-template"
  description = "A template for Terraform module repositories"
  visibility  = "public"

  auto_init   = true
  is_template = true

  has_issues   = true
  has_projects = false
  has_wiki     = false

  gitignore_template = "Terraform"
  license_template   = "unlicense"
}

resource "github_repository_file" "tf_module_repo_template_readme" {
  repository = github_repository.tf_module_repo_template.name
  branch     = github_repository.tf_module_repo_template.default_branch
  file       = "README.md"

  commit_message = "README template"
  commit_author  = "Terraform Cloud"
  commit_email   = "fabiend@app.terraform.io"

  overwrite_on_create = true

  content = templatefile("${path.module}/readme.md.tpl", {})
}

resource "github_repository_file" "tf_module_repo_template_github_action_tflint" {
  repository = github_repository.tf_module_repo_template.name
  branch     = github_repository.tf_module_repo_template.default_branch
  file       = ".github/workflows/tflint.yml"

  commit_message = "Set up TFLint GitHub action"
  commit_author  = "Terraform Cloud"
  commit_email   = "fabiend@app.terraform.io"

  overwrite_on_create = true

  content = templatefile("${path.module}/github_action_tflint.yml.tpl", {})
}

resource "github_repository_file" "tf_module_repo_template_github_action_tfdocs" {
  repository = github_repository.tf_module_repo_template.name
  branch     = github_repository.tf_module_repo_template.default_branch
  file       = ".github/workflows/tfdocs.yml"

  commit_message = "Set up TFDocs GitHub action"
  commit_author  = "Terraform Cloud"
  commit_email   = "fabiend@app.terraform.io"

  overwrite_on_create = true

  content = templatefile("${path.module}/github_action_tfdocs.yml.tpl", {})
}

resource "github_repository_file" "tf_module_repo_template_pre_commit_config" {
  repository = github_repository.tf_module_repo_template.name
  branch     = github_repository.tf_module_repo_template.default_branch
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

resource "github_repository_file" "tf_module_repo_template_main_tf" {
  repository = github_repository.tf_module_repo_template.name
  branch     = github_repository.tf_module_repo_template.default_branch
  file       = "main.tf"

  commit_message = "Write placeholder main.tf"
  commit_author  = "Terraform Cloud"
  commit_email   = "fabiend@app.terraform.io"

  overwrite_on_create = true

  content = templatefile("${path.module}/main.tf.tpl", {})
}

resource "github_repository_file" "tf_module_repo_template_outputs_tf" {
  repository = github_repository.tf_module_repo_template.name
  branch     = github_repository.tf_module_repo_template.default_branch
  file       = "outputs.tf"

  commit_message = "Write placeholder outputs.tf"
  commit_author  = "Terraform Cloud"
  commit_email   = "fabiend@app.terraform.io"

  overwrite_on_create = true

  content = templatefile("${path.module}/outputs.tf.tpl", {})
}

resource "github_repository_file" "tf_module_repo_template_providers_tf" {
  repository = github_repository.tf_module_repo_template.name
  branch     = github_repository.tf_module_repo_template.default_branch
  file       = "providers.tf"

  commit_message = "Write placeholder providers.tf"
  commit_author  = "Terraform Cloud"
  commit_email   = "fabiend@app.terraform.io"

  overwrite_on_create = true

  content = templatefile("${path.module}/providers.tf.tpl", {})
}

resource "github_repository_file" "tf_module_repo_template_variables_tf" {
  repository = github_repository.tf_module_repo_template.name
  branch     = github_repository.tf_module_repo_template.default_branch
  file       = "variables.tf"

  commit_message = "Write placeholder variables.tf"
  commit_author  = "Terraform Cloud"
  commit_email   = "fabiend@app.terraform.io"

  overwrite_on_create = true

  content = templatefile("${path.module}/variables.tf.tpl", {})
}