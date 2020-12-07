output "vpc_id" {
    value = module.vpc.vpc_id
}

output "cluster_id" {
    value = aws_ecs_cluster.cluster.id
}

output "private_subnets" {
    value = module.vpc.private_subnets
}

output "public_subnets" {
    value = module.vpc.public_subnets
}

output "alb-security-group" {
    value = module.loadbalancer_sg.this_security_group_id
}