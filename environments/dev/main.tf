provider "aws" {
  region = "us-east-1"  # N. Virginia region
}

module "terraform_state_bucket" {
  source = "../../modules/s3"
  bucket_name = "githubackendcicd-s3"
} 