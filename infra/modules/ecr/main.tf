# Create an AWS ECR repository
resource "aws_ecr_repository" "elastic_container_registry" {
  name                 = var.repository_name
  image_tag_mutability = "MUTABLE"
}
