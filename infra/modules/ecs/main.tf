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
          containerPort = 80 # Port the container listens on
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

# ECS Service: manages the running instances of the task definition defined above
resource "aws_ecs_service" "custom_api_service" {
  name            = "devops-challenge-service"
  cluster         = aws_ecs_cluster.elastic_container_service.id
  launch_type     = "FARGATE"
  desired_count   = 1 #number of container instances to run
  task_definition = aws_ecs_task_definition.ecs_task.arn


  # ECS schedules tasks across both subnets: public_subnet_a and public_subnet_b
  network_configuration {
    subnets          = var.public_subnet_ids
    security_groups  = [var.aws_application_load_balancer_security_group_id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.aws_lb_target_group_blue_arn
    container_name   = "custom-api"
    container_port   = 80
  }

  depends_on = [
    var.aws_lb_listener_blue_arn
  ]
}
