variable "project_name" {
  type        = string
  description = "Prefix for resource names"
}

# VPC variables
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

# Route table variables
variable "public_route_cidr" {
  type        = string
  description = "CIDR block used for internet access in the public route table"
  default     = "0.0.0.0/0"
}