terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.31.0"
    }
  }
}

terraform {
  backend "s3" {
    bucket  = "ecom-infra-state"
    key     = "ecom/dev/terraform.tfstate"
    profile = "nikesh"
    region  = "us-east-1"
  }
}

provider "aws" {
  profile = "nikesh"
  region  = "us-east-1"
}
