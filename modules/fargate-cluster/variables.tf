variable "cluster_name" {
    type = string
    description = "Name of the fargate cluster"
}

variable "vpc_cidr" {
    type = string
    description = "CIDR block for the VPC"
}


variable "zones" {
    type = list
    description = "List of avalibility zones where the VPC will live"
}

variable "private_subnets" {
    type = list
    description = "List of netblocks to use for creating private subnets in the VPC"
}

variable "public_subnets" {
    type = list
    description = "List of netblocks to use for creating public subnets in the VPC"
}