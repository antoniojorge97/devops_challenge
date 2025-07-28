# Expose the ARNs of the target groups to be used in the pipeline (for switching automation)
output "tg_blue_arn" {
  value = module.alb.tg_blue_arn
}

output "tg_green_arn" {
  value = module.alb.tg_green_arn
}

# Expose DNS name of the ALB for health check validation in the pipeline
output "alb_dns_name" {
  value = module.alb.alb_dns_name
}


output "aws_lb_http_listener_arn" {
  value = module.alb.aws_lb_http_listener_arn
}




