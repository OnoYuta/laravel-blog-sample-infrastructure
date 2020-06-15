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

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.project_name}-igw"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "${var.project_name}-public-route-table"
  }
}

resource "aws_route_table_association" "public_subnet_1_route_table_association" {
  route_table_id = aws_route_table.public_route_table.id
  subnet_id      = aws_subnet.public_subnet_1.id
}

resource "aws_route_table_association" "public_subnet_2_route_table_association" {
  route_table_id = aws_route_table.public_route_table.id
  subnet_id      = aws_subnet.public_subnet_2.id
}