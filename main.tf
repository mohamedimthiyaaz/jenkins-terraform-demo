terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

resource "random_id" "suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "demo" {
  bucket        = "jenkins-tf-demo-${random_id.suffix.hex}"
  force_destroy = true

  tags = {
    Project   = "jenkins-terraform-demo"
    ManagedBy = "terraform"
  }
}

output "bucket_name" {
  value = aws_s3_bucket.demo.bucket
}