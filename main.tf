terraform {
  required_version = ">= 1.5.0"

  backend "s3" {
    bucket       = "tfstate-imthiyaaz-12345"
    key          = "jenkins-demo/terraform.tfstate"
    region       = "ap-south-1"
    use_lockfile = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}