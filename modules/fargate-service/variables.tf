variable "service_name" {
    type = string
    description = "name of the fargate service to deploy"
}

variable "container_image" {
    type = string
    description = "container image for this service"
}

variable "container_port" {
    type = number
    description = "container port for this service"
}

variable "container_proto" {
    type = string
    description = "protocol to connect to the container, defaults to TCP"
    default = "tcp"
}

variable "container_name" {
    type = string
    description = "name for the container running in the task definition"
}

variable "container_cpu" {
    type = number
    description = "number of CPU credits for the service"
    default = 256
}

variable "container_memory" {
    type = number
    description = "number of memory credits for the service"
    default = 512
}

variable "aws_region" {
    type = string
    description = "AWS region where this infrastructure will be created"
}

variable "cluster_id" {
    type = string
    description = "cluster id where this service will be created"
}

variable "vpc_id" {
    type = string
    description = "id of the vpc where the fargate cluster is running"
}

variable "private_subnets" {
    type = list
    description = "private subnets where the fargate tasks will run"
}

variable "public_subnets" {
    type = list
    description = "public subnets where the fargate tasks will run"
}

variable "health_check_path" {
    type = string
    description = "path to use for service health check"
    default = "/"
}

variable "load_balancer_security_group" {
    type = string
    description = "security group applied to the ALB which is created for each service"
}