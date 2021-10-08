name: "TFLint + Checkov + Terraform"

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

  checkov:
    needs: tflint
    runs-on: ubuntu-latest
    name: checkov-action
    steps:
      - name: Checkout repo
        uses: actions/checkout@v2

      - name: Run Checkov action
        id: checkov
        uses: bridgecrewio/checkov-action@master
        with:
          directory: ./

  terraform:
    needs: checkov
    name: "Terraform"
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v2

      - name: Setup Terraform
        uses: hashicorp/setup-terraform@v1
        with:
          terraform_version: ~1
          cli_config_credentials_token: $${{ secrets.TFC_API_TOKEN }}

      - name: Terraform Init
        id: init
        run: terraform init
      
      - name: Terraform Validate
        id: validate
        run: terraform validate -no-color

      - name: Terraform Plan
        id: plan
        if: github.event_name == 'pull_request'
        run: terraform plan -no-color
        continue-on-error: true

      - uses: actions/github-script@0.9.0
        if: github.event_name == 'pull_request'
        env:
          PLAN: "terraform\n$${{ steps.plan.outputs.stdout }}"
        with:
          github-token: $${{ secrets.GITHUB_TOKEN }}
          script: |
            const output = `#### Terraform Format and Style 🖌\`$${{ steps.fmt.outcome }}\`
            #### Terraform Initialization ⚙️\`$${{ steps.init.outcome }}\`
            #### Terraform Validation 🤖\`$${{ steps.validate.outcome }}\`
            #### Terraform Plan 📖\`$${{ steps.plan.outcome }}\`
            <details><summary>Show Plan</summary>
            \`\`\`\n
            $${process.env.PLAN}
            \`\`\`
            </details>
            *Pusher: @$${{ github.actor }}, Action: \`$${{ github.event_name }}\`*`;
            github.issues.createComment({
              issue_number: context.issue.number,
              owner: context.repo.owner,
              repo: context.repo.repo,
              body: output
            })

      - name: Terraform Plan Status
        if: steps.plan.outcome == 'failure'
        run: exit 1

      - name: Terraform Apply
        if: github.ref == 'refs/heads/main' && github.event_name == 'push'
        run: terraform apply -auto-approve