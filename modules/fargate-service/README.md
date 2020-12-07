## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| aws\_region | AWS region where this infrastructure will be created | `string` | n/a | yes |
| cluster\_id | cluster id where this service will be created | `string` | n/a | yes |
| container\_cpu | number of CPU credits for the service | `number` | `256` | no |
| container\_image | container image for this service | `string` | n/a | yes |
| container\_memory | number of memory credits for the service | `number` | `512` | no |
| container\_name | name for the container running in the task definition | `string` | n/a | yes |
| container\_port | container port for this service | `number` | n/a | yes |
| container\_proto | protocol to connect to the container, defaults to TCP | `string` | `"tcp"` | no |
| health\_check\_path | path to use for service health check | `string` | `"/"` | no |
| load\_balancer\_security\_group | security group applied to the ALB which is created for each service | `string` | n/a | yes |
| private\_subnets | private subnets where the fargate tasks will run | `list` | n/a | yes |
| public\_subnets | public subnets where the fargate tasks will run | `list` | n/a | yes |
| service\_name | name of the fargate service to deploy | `string` | n/a | yes |
| vpc\_id | id of the vpc where the fargate cluster is running | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| alb\_url | n/a |

