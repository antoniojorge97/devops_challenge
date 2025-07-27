provider "aws" {
  region = "eu-west-1"  # change to your region
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}


# Modules 

module "vpc" {
  source                      = "./modules/vpc"
  vpc_cidr                    = var.vpc_cidr
  project_name                = var.project_name
  public_subnet_a_cidr        = var.public_subnet_a_cidr
  public_subnet_b_az          = var.public_subnet_b_az
  public_subnet_a_az          = var.public_subnet_a_az
  public_subnet_b_cidr        = var.public_subnet_b_cidr
  public_route_cidr           = var.public_route_cidr
}

module "ecr" {
  source                      = "./modules/ecr"
  repository_name             = var.repository_name
}

module "ecs" {
  source                      = "./modules/ecs"
  aws_account_id              = var.aws_account_id
  aws_region                  = var.aws_region
  ecs_task_execution_role_arn = module.iam.ecs_task_execution_role_arn
}

module "iam" {
  source = "./modules/iam"
}