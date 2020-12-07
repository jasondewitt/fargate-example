locals {
    aws_region = "us-west-2"

    vpc_cidr = "10.0.0.0/16"

}

provider "aws" {
  version = "~> 2.7"
  region  = local.aws_region
}


module "fargate-cluster" {
    source = "./modules/fargate-cluster"

    cluster_name = "fargate-cluster"
    vpc_cidr = local.vpc_cidr
    zones = ["us-west-2a", "us-west-2b", "us-west-2c"]
    private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
    public_subnets = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

}

module "sample-service" {
    source = "./modules/fargate-service"

    aws_region = local.aws_region
    cluster_id = module.fargate-cluster.cluster_id
    vpc_id = module.fargate-cluster.vpc_id

    service_name = "fargate-sample"
    container_name = "fargate-sample"
    container_image = "ghcr.io/jasondewitt/sample-service:master-401017809"
    container_port = "5000"

    container_cpu = 256
    container_memory = 512

    private_subnets = module.fargate-cluster.private_subnets
    public_subnets = module.fargate-cluster.public_subnets
    load_balancer_security_group = module.fargate-cluster.alb-security-group
}

output "sample-url" {
    value = module.sample-service.alb_url
}