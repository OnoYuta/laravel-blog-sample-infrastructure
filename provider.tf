variable "access_key" {}
variable "secret_key" {}

terraform {
  required_version = ">= 0.11.0"
}

provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.region
}