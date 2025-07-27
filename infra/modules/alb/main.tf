# Create SG for the ALB. 
# In AWS, by default, inbound traffic is not allowed. This explicitly allows HTTP traffic on port 80.
resource "aws_security_group" "application_load_balancer_security_group" {
  name        = "alb-sg"
  description = "Allow HTTP inbound traffic"
  vpc_id      = var.virtual_private_cloud_id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# create an Application Load Balancer (ALB)
resource "aws_lb" "application_load_balancer" {
  name               = "devops-challenge-alb"
  internal           = false # makes it public accessible
  load_balancer_type = "application"
  security_groups    = [aws_security_group.application_load_balancer_security_group.id]
  subnets            = [var.public_subnet_a_id, var.public_subnet_b_id]

  enable_deletion_protection = false
}

# Create 2 target groups: blue and green
resource "aws_lb_target_group" "blue" {
  name        = "tg-blue"
  port        = 80 # Matches the container port
  protocol    = "HTTP"
  vpc_id      = var.virtual_private_cloud_id
  target_type = "ip"
  health_check {
    path                = "/message"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200"
  }
}

resource "aws_lb_target_group" "green" {
  name        = "tg-green"
  port        = 80 # Matches the container port
  protocol    = "HTTP"
  vpc_id      = var.virtual_private_cloud_id
  target_type = "ip"
  health_check {
    path                = "/message"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200"
  }
}


resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.application_load_balancer.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward" // Forward traffic to the blue target group
    target_group_arn = var.active_target_group // The actual target group ARN
  }
}

