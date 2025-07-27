variable "project_name" {
  type        = string
  description = "Prefix for resource naming"
}

variable "aws_account_id" {
  type        = string
  description = "AWS account ID"
}

variable "aws_region" {
  type        = string
  description = "AWS region"
}

# VPC Configuration
variable "vpc_cidr" {
  type        = string
  description = "The CIDR block for the VPC"
}

# Public Subnets Configuration
variable "public_subnet_a_cidr" {
  type        = string
  description = "CIDR block for public subnet A"
}

variable "public_subnet_a_az" {
  type        = string
  description = "Availability Zone for public subnet A"
}

variable "public_subnet_b_cidr" {
  type        = string
  description = "CIDR block for public subnet B"
}

variable "public_subnet_b_az" {
  type        = string
  description = "Availability Zone for public subnet B"
}

variable "public_route_cidr" {
  type        = string
  description = "CIDR block used for internet access in the public route table"
}

# ECR Repository Name
variable "repository_name" {
  type        = string
  description = "ECR repository's name"
  default     = "devops-challenge-ecr"
}