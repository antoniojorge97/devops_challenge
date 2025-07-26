# Create a Virtual Private Cloud (VPC) in AWS

resource "aws_vpc" "virtual_private_cloud" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  # Name displayed in AWS
  tags = {
    Name = "${var.project_name}-virtual-private-cloud"
  }
}


# Create an Internet Gateway in the VPC

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.virtual_private_cloud.id

  tags = {
    Name = "${var.project_name}-internet-gateway"
  }
}

# Creates 2 public subnets in different availability zones

resource "aws_subnet" "public_a" {
  vpc_id                  = aws_vpc.virtual_private_cloud.id
  cidr_block              = var.public_subnet_a_cidr
  availability_zone       = var.public_subnet_a_az
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-public-subnet-a"
  }
}

resource "aws_subnet" "public_b" {
  vpc_id                  = aws_vpc.virtual_private_cloud.id
  cidr_block              = var.public_subnet_b_cidr
  availability_zone       = var.public_subnet_b_az
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-public-subnet-b"
  }
}
