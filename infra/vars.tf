variable "vpc_cidr" {
  type        = string
  description = "The CIDR block for the VPC"
}

variable "project_name" {
  type        = string
  description = "Prefix for resource naming"
}

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