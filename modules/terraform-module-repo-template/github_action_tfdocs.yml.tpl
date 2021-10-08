name: Generate Terraform docs

on:
  pull_request:

jobs:
  tfdocs:
    runs-on: ubuntu-latest
    name: Terraform-Docs
    steps:
    - name: Checkout repository
      uses: actions/checkout@v2
      with:
        ref: $${{ github.event.pull_request.head.ref }}

    - name: Render Terraform docs inside the README.md and push changes back to PR branch
      uses: terraform-docs/gh-actions@v0.10.0
      with:
        working-dir: .
        output-file: README.md
        output-method: inject
        git-push: "true"