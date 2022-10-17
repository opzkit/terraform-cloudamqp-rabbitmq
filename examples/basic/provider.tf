provider "aws" {
  skip_requesting_account_id  = true
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  s3_use_path_style           = true
  region                      = "eu-west-1"
  access_key                  = "mock_access_key"
  secret_key                  = "mock_secret_key"
}
provider "cloudamqp" {
  apikey = "dummy"
}

terraform {
  required_providers {
    cloudamqp = {
      source  = "cloudamqp/cloudamqp"
      version = "~> 1.15"
    }

    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}
