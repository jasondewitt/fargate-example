locals {
    log_group_name = "/ecs/${var.service_name}-logs"
}

resource "aws_cloudwatch_log_group" "sample-service-logs" {
  name = local.log_group_name
}

# execution role for the task
resource "aws_iam_role" "execution-role" {
  name               = "fargate-${var.service_name}-execution-role"
  assume_role_policy = data.aws_iam_policy_document.ecs-task-assume-role.json
}

# define task
resource "aws_ecs_task_definition" "task-definition" {
  family = "sample-service"

  execution_role_arn = aws_iam_role.execution-role.arn

  container_definitions = <<EOF
  [
    {
      "name": "${var.container_name}",
      "image": "${var.container_image}",
      "portMappings": [
        {
          "containerPort": ${var.container_port}
        }
      ],
      "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-region": "${var.aws_region}",
          "awslogs-group": "${local.log_group_name}",
          "awslogs-stream-prefix": "ecs"
        }
      }
    }
  ]
  EOF

  # These are the minimum values for Fargate containers.
  cpu = 256
  memory = 512
  requires_compatibilities = ["FARGATE"]

  # This is required for Fargate containers (more on this later).
  network_mode = "awsvpc"
}

## define Fargate service
resource "aws_ecs_service" "fargate-service" {
  name            = var.service_name
  task_definition = aws_ecs_task_definition.task-definition.arn
  cluster = var.cluster_id
  launch_type     = "FARGATE"

  desired_count = 1

  network_configuration {
      assign_public_ip = false

      security_groups = [
          module.app_sg.this_security_group_id
      ]

      subnets = var.private_subnets
  }

  load_balancer {
      target_group_arn = aws_lb_target_group.target-group.arn
      container_name = var.container_name
      container_port = var.container_port

  }
}

resource "aws_alb" "fargate-alb" {
  name               = "fargate-t${var.service_name}-alb"
  internal           = false
  load_balancer_type = "application"

  subnets = var.public_subnets

  security_groups = [
    var.load_balancer_security_group
  ]
}

resource "aws_lb_target_group" "target-group" {
  name        = "${var.service_name}-tg"
  port        = var.container_port
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id

  health_check {
    enabled = true
    path    = var.health_check_path
  }

  depends_on = [aws_alb.fargate-alb]
}

resource "aws_alb_listener" "sample-service-http-listener" {
  load_balancer_arn = aws_alb.fargate-alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target-group.arn
  }
}