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

  backend "s3" {
    bucket         = "devops-challenge-tfstate-967694737948"
    key            = "terraform.tfstate"
    region         = "eu-west-1"
    encrypt        = true
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
  source                                          = "./modules/ecs"
  aws_account_id                                  = var.aws_account_id
  aws_region                                      = var.aws_region
  ecs_task_execution_role_arn                     = module.iam.ecs_task_execution_role_arn
  aws_lb_target_group_blue_arn                    = module.alb.aws_lb_target_group_blue_arn
  public_subnet_ids                               = [module.vpc.public_subnet_a_id, module.vpc.public_subnet_b_id]
  aws_application_load_balancer_security_group_id = module.alb.aws_application_load_balancer_security_group_id
  aws_lb_http_listener_arn                        = module.alb.aws_lb_http_listener_arn
  active_target_group                             = var.deployment_color == "blue" ? module.alb.tg_blue_arn : module.alb.tg_green_arn
  deployment_color                                = var.deployment_color
}

module "iam" {
  source = "./modules/iam"
}

module "alb" {
  source                      = "./modules/alb"
  virtual_private_cloud_id    = module.vpc.vpc_id
  public_subnet_a_id          = module.vpc.public_subnet_a_id
  public_subnet_b_id          = module.vpc.public_subnet_b_id
  active_target_group         = var.deployment_color == "blue" ? module.alb.tg_blue_arn : module.alb.tg_green_arn
}