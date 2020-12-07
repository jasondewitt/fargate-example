output "alb_url" {
  value = "http://${aws_alb.fargate-alb.dns_name}"
}