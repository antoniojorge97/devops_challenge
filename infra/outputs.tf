# Expose the ARNs of the target groups to be used in the pipeline (for switching automation)
output "tg_blue_arn" {
  value = module.alb.tg_blue_arn
}

output "tg_green_arn" {
  value = module.alb.tg_green_arn
}
