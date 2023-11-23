terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "eu-central-2"
}

terraform {
  backend "s3" {
    bucket = "mregli"
    key    = "tfs/dep/mreglab-aws-org-terraform-dev.tfstate"
    region = "eu-central-2"
  }
}
