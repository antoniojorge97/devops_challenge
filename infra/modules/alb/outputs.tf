output "aws_application_load_balancer_security_group_id" {
  value = aws_security_group.application_load_balancer_security_group.id
}

output "aws_lb_http_listener_arn" {
  value = aws_lb_listener.http_listener.arn
}


# Expose the ARNs of the target groups to be used in the pipeline (for switching automation)
output "tg_blue_arn" {
  value = aws_lb_target_group.blue.arn
}

output "tg_green_arn" {
  value = aws_lb_target_group.green.arn
}

# Expose DNS name of the ALB for health check validation in the pipeline
output "alb_dns_name" {
  value = aws_lb.application_load_balancer.dns_name
}