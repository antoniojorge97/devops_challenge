output "aws_lb_target_group_blue_arn" {
  value = aws_lb_target_group.blue.arn
}

output "aws_application_load_balancer_security_group_id" {
  value = aws_security_group.application_load_balancer_security_group.id
}

output "aws_lb_http_listener_arn" {
  value = aws_lb_listener.http_listener.arn
}