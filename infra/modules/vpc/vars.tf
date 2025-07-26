variable "project_name" {
  type        = string
  description = "Prefix for resource names"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC."
}


# Subnet variables

variable "public_subnet_a_cidr" {
  type        = string
  description = "CIDR block for public subnet A"
}

variable "public_subnet_a_az" {
  type        = string
  description = "AZ for subnet A"
}

variable "public_subnet_b_cidr" {
  type        = string
  description = "CIDR block for public subnet B"
}

variable "public_subnet_b_az" {
  type        = string
  description = "AZ for subnet B"
}