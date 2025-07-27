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