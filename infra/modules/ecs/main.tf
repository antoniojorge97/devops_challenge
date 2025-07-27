resource "aws_ecs_cluster" "elastic_container_service" {
  name = "devops-challenge-cluster"
}

resource "aws_cloudwatch_log_group" "ecs_logs" {
  name              = "devops-challenge-ecs-logs"
  retention_in_days = 3
}

# Task Definition: blueprint for running the container
resource "aws_ecs_task_definition" "ecs_task" {
  family                   = "devops-challenge-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256" #minimum CPU for Fargate
  memory                   = "512" #minimum memory for Fargate
  execution_role_arn       = var.ecs_task_execution_role_arn

  container_definitions = jsonencode([
    {
      name      = "custom-api"
      image     = "${var.aws_account_id}.dkr.ecr.${var.aws_region}.amazonaws.com/devops-challenge-ecr:latest"
      essential = true
      portMappings = [
        {
          containerPort = 8080 # Port the container listens on
          protocol      = "tcp"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "devops-challenge-ecs-logs"
          awslogs-region        = "${var.aws_region}"
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])
}
