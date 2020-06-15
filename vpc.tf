resource "aws_vpc" "vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "${var.project_name}-vpc"
  }
}

resource "aws_subnet" "public_subnet_1" {
  vpc_id            = aws_vpc.vpc.id
  availability_zone = "${var.region}a"
  cidr_block        = cidrsubnet(aws_vpc.vpc.cidr_block, 8, 0)
  tags = {
    Name = "${var.project_name}-public_subnet_1"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id            = aws_vpc.vpc.id
  availability_zone = "${var.region}c"
  cidr_block        = cidrsubnet(aws_vpc.vpc.cidr_block, 8, 16)
  tags = {
    Name = "${var.project_name}-public_subnet_2"
  }
}