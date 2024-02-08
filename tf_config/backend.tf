terraform {
  backend "s3" {
    bucket  = "daniel-interview-s3-nice-tf-backend"
    key     = "terraform_backend/terraform.tfstate"
    encrypt = true
    region  = "us-east-1"
    profile = "daniel-interview"
  }
}