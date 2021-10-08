name: TFLint

on:
  push:
    branches:
      - main
  pull_request:

jobs:
  tflint:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout source code
        uses: actions/checkout@v2

      - name: Cache plugin dir
        uses: actions/cache@v2
        with:
          path: ~/.tflint.d/plugins
          key: tflint-$${{ hashFiles('.tflint.hcl') }}

      - name: Setup Terraform
        uses: hashicorp/setup-terraform@v1
        with:
          terraform_version: ~1

      - name: Terraform Format
        run: terraform fmt -check

      - name: Setup TFLint
        uses: terraform-linters/setup-tflint@v1
        with:
          tflint_version: latest
          github_token: $${{ secrets.GITHUB_TOKEN }}

      - name: Show version
        run: tflint --version

      - name: Init TFLint
        run: tflint --init

      - name: Run TFLint
        run: tflint -f compact