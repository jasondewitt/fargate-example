## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| cluster\_name | Name of the fargate cluster | `string` | n/a | yes |
| private\_subnets | List of netblocks to use for creating private subnets in the VPC | `list` | n/a | yes |
| public\_subnets | List of netblocks to use for creating public subnets in the VPC | `list` | n/a | yes |
| vpc\_cidr | CIDR block for the VPC | `string` | n/a | yes |
| zones | List of avalibility zones where the VPC will live | `list` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| alb-security-group | n/a |
| cluster\_id | n/a |
| private\_subnets | n/a |
| public\_subnets | n/a |
| vpc\_id | n/a |

