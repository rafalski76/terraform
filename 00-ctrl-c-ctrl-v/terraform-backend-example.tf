terraform {
  required_version = ">= 1.10"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  backend "s3" {
    bucket       = "tfstate-bucket-name" # must be hardcoded here :(
    key          = "terraform.tfstate"
    region       = "eu-west-1" # Bucket region, not deployment region
    use_lockfile = true        # natywne blokowanie stanu w S3 (zastępuje DynamoDB)
  }
}
