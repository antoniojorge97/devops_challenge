variable "virtual_private_cloud_id" {
  type        = string
  description = "VPC Id"
}

variable "public_subnet_a_id" {
  type        = string
  description = "Public subnet A Id"
}

variable "public_subnet_b_id" {
  type        = string
  description = "Public subnet B Id"
}

variable "active_target_group" {
  description = "ARN of the active target group (blue or green)"
  type        = string
}