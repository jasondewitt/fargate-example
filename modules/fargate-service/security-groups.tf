module "app_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "application SG"
  description = "allow container port traffic from LB secgrp to fargate task"
  vpc_id      = var.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = var.container_port
      to_port     = var.container_port
      protocol    = "tcp"
      description = "sample-service porot"
      cidr_blocks = "10.0.0.0/16"
    }
  ]

  egress_with_cidr_blocks = [
    {
      rule        = "all-all"
      cidr_blocks = "0.0.0.0/0"
    },
  ]

}
