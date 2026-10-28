variable "region" {
  type    = string
  default = "ap-south-1"
}

variable "environment" {
  type        = string
  description = "dev or prod"
}

variable "instance_type" {
  type = string
}