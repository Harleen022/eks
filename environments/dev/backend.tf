terraform {
  backend "s3" {
    bucket         = "my-terraform-state-bucket-dev"  # Change this to match your bucket name
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"  # Updated region
    encrypt        = true
  }
} 