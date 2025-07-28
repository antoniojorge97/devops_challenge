# Terraform variables for the DevOps Challenge infrastructure`
aws_account_id          = "967694737948"
aws_region              = "eu-west-1"

# VPC settings
vpc_cidr = "10.0.0.0/16"

# Public subnets
public_subnet_a_cidr = "10.0.1.0/24"
public_subnet_b_cidr = "10.0.2.0/24"

# Availability Zones
public_subnet_a_az = "eu-west-1a"
public_subnet_b_az = "eu-west-1b"

# Project-wide tag
project_name = "devops-challenge"

# Active Target Group for blue/green deployment
# active_target_group = "arn:aws:elasticloadbalancing:eu-west-1:967694737948:targetgroup/tg-blue/23b29b6b5eb25790"

# Route Table CIDR (for internet access)
public_route_cidr = "0.0.0.0/0"
