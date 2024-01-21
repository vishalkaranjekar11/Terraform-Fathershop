terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region     = "us-east-1"
  access_key = "AKIA6FAFPSAT3CLILMHV"
  secret_key = "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"
}

provider "aws" {
  region     = "us-east-2"
  access_key = "AKIA6FAFPSAT3CLILMHV"
  secret_key = "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"
}
