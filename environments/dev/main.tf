provider "aws" {
  region = "us-east-1"  # Updated region
}

module "terraform_state_bucket" {
  source = "../../modules/s3"
  bucket_name = "my-terraform-state-bucket-dev"  # Change this to your desired bucket name
} 