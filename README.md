# Terraform Infrastructure as Code with GitHub Actions

This repository contains Terraform configurations for AWS infrastructure, with automated deployment using GitHub Actions.

## Directory Structure

```
.
├── modules/
│   └── s3/                    # S3 bucket module
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
├── environments/
│   └── dev/                   # Development environment
│       ├── main.tf
│       ├── backend.tf
│       └── versions.tf
└── .github/
    └── workflows/
        └── terraform.yml      # GitHub Actions workflow
```

## GitHub Actions Workflow

The repository includes a GitHub Actions workflow that automates Terraform operations:

- On Pull Requests:
  - Runs `terraform fmt` check
  - Runs `terraform init`
  - Runs `terraform validate`
  - Runs `terraform plan` and posts the results as a PR comment

- On Push to Main:
  - Runs all above checks
  - Runs `terraform apply` automatically

## Required GitHub Secrets

Before using the workflow, set up the following secrets in your GitHub repository:

1. `AWS_ACCESS_KEY_ID`: Your AWS access key ID
2. `AWS_SECRET_ACCESS_KEY`: Your AWS secret access key

To add these secrets:
1. Go to your repository on GitHub
2. Navigate to Settings > Secrets and variables > Actions
3. Click "New repository secret"
4. Add each secret with its corresponding value

## Usage

1. Create a new branch for your changes:
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. Make your changes to the Terraform files

3. Commit and push your changes:
   ```bash
   git add .
   git commit -m "Description of your changes"
   git push origin feature/your-feature-name
   ```

4. Create a Pull Request on GitHub

5. The GitHub Actions workflow will automatically:
   - Run Terraform format checks
   - Initialize Terraform
   - Create a plan and post it as a comment on your PR

6. Once approved and merged to main, the workflow will automatically apply the changes

## Security Notes

- The GitHub Actions workflow uses OIDC to authenticate with AWS
- All S3 buckets are encrypted by default
- Public access to S3 buckets is blocked
- State files are stored in S3 with versioning enabled 