# Terraform Cloud workspace

Short description of the workspace

## Read, execute, then remove this

The template that created this workspace set up a GitHub action that expects you to set up a repository secret called TFC_API_TOKEN in your repo settings, which will be used by the action to run Terraform via Terraform Cloud's API. You must create a personal token (or use an existing one) in TFC and set it in this repo's secrets, or the action will fail.