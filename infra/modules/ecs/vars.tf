variable "aws_account_id" {
  type        = string
  description = "AWS account ID"
}

variable "aws_region" {
  type        = string
  description = "AWS region"
}

variable "ecs_task_execution_role_arn" {
  type        = string
  description = "task execution role ARN"
}

variable "aws_lb_target_group_blue_arn" {
  type        = string
  description = "Application Load Balancer target group ARN"
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs for ECS service"
  type        = list(string)
}

variable "aws_application_load_balancer_security_group_id" {
  type        = string
  description = "ALB security group Id"
}

variable "aws_lb_listener_blue_arn" {
  type        = string
  description = "ALB listener ARN for blue target group"
}