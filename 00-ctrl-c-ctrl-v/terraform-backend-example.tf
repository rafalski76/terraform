terraform {
  required_version = "~> 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }

  backend "s3" {
    bucket         = "tfstate-bucket-name" # must be hardcoded here :(
    key            = "terraform.tfstate"
    region         = "eu-west-1" # Bucket region, not deployment region
    dynamodb_table = "tfstate"
  }
}
