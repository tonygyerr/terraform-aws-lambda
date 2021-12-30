## Module Lambda
```terraform
data "archive_file" "service" {
  type        = "zip"
  source_dir  = "${path.module}/src"
  output_path = "${path.module}/src/out/thumbnail.zip"
}

module "lambda" {
  source = "git::ssh://git@github.com:tonygyerr/terraform-aws-api-lambda.git"
  # source  = "../"
  api_rest_api_id        = var.api_rest_api_id
  api_http_method        = var.api_http_method
  api_resource_path      = var.api_resource_path
  region                 = var.aws_region
  environment            = var.environment
  filename               = data.archive_file.service.output_path #data.archive_file.this.output_base64sha256
  app_name            = var.app_name
  lambda_path            = var.lambda_path
  layer_name             = var.layer_name
  function_name          = var.function_name
  stack_name             = var.stack_name
  iam_role_arn           = var.iam_role_arn
}

```
## Prerequisites
- Docker (for using Docker Image of dependencies)
- Git
- Terraform
- AWS Key pair for Terraform provisioning.
- AWS S3 bucket for remote terraform state file (tfstate)
- AWS Dynamo Database for tfstate table state lock 

## How to run this Module using Terraform Commands
```bash
cd examples
terraform get
terraform init -backend-config ../backend-config/dev.tfvars
terraform plan -var-file="../env-config/dev.tfvars"
terraform apply -var-file="../env-config/dev.tfvars" -auto-approve
terraform destroy -var-file="../env-config/dev.tfvars"
```

## Requirements

| Name | Version |
|------|---------|
| aws | ~> 2.0 |

## Providers

| Name | Version |
|------|---------|
| aws | ~> 2.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| account\_id | n/a | `string` | `""` | no |
| api\_http\_method | n/a | `string` | n/a | yes |
| api\_resource\_path | n/a | `string` | n/a | yes |
| api\_rest\_api\_id | n/a | `string` | n/a | yes |
| app\_tags | optional lambda tags | `map(string)` | <pre>{<br>  "costcenter": "",<br>  "environment": "",<br>  "name": "",<br>  "owner": "",<br>  "project": ""<br>}</pre> | no |
| app_name | n/a | `string` | `""` | no |
| aws\_region | Default AWS Region | `string` | `"us-east-1"` | no |
| cw\_event\_name | n/a | `string` | `""` | no |
| description | Description of your Lambda Function | `string` | `""` | no |
| environment | n/a | `any` | n/a | yes |
| extra\_tags | A map of extra tags provided by the user | `map(string)` | `{}` | no |
| filename | path to the filename | `string` | `""` | no |
| function\_name | name of your lambda function name | `any` | n/a | yes |
| handler | n/a | `string` | `"lambda.handler"` | no |
| http\_method | n/a | `string` | `"GET"` | no |
| iam\_role\_arn | The Role | `string` | n/a | yes |
| lambda\_exec\_policy | n/a | `string` | `"{\n    \"Version\": \"2012-10-17\",\n    \"Statement\": [\n        {\n            \"Effect\": \"Allow\",\n            \"Action\": [\n                \"logs:CreateLogGroup\",\n                \"logs:CreateLogStream\",\n                \"logs:PutLogEvents\"\n            ],\n            \"Resource\": [ \"arn:aws:logs:*:*:*\" ]\n        },\n        {\n            \"Effect\": \"Allow\",\n            \"Resource\": \"*\",\n            \"Action\": [\n                \"ec2:DescribeInstances\",\n                \"ec2:CreateNetworkInterface\",\n                \"ec2:AttachNetworkInterface\",\n                \"ec2:DescribeNetworkInterfaces\",\n                \"autoscaling:CompleteLifecycleAction\",\n                \"lambda:InvokeFunction\"\n            ]\n        },\n        {\n            \"Effect\": \"Allow\",\n            \"Action\": [\n                \"s3:PutObject\",\n                \"s3:GetObject\",\n                \"s3:PutObject\",\n                \"s3:DeleteObject\",\n                \"s3:ListBucket\"\n            ],\n            \"Resource\": [ \"arn:aws:s3:::*\" ]\n        }\n    ]\n}\n"` | no |
| lambda\_path | n/a | `string` | n/a | yes |
| layer\_name | n/a | `string` | n/a | yes |
| memory\_size | n/a | `string` | `"256"` | no |
| module\_name | n/a | `string` | `""` | no |
| publish | n/a | `bool` | `false` | no |
| region | ec2 region for the vpc | `string` | n/a | yes |
| reserved\_concurrent\_executions | n/a | `string` | `"-1"` | no |
| runtime | n/a | `string` | `"python3.8"` | no |
| security\_group\_ids | n/a | `string` | `""` | no |
| stack\_name | n/a | `string` | n/a | yes |
| subnet\_ids | n/a | `string` | `""` | no |
| timeout | n/a | `number` | `3` | no |
| vpc\_config | Configuration options for VPC adn subnets | `map(list(string))` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| lambda\_arn | n/a |
| lambda\_function\_name | n/a |
| lambda\_invoke\_arn | n/a |
| lambda\_permission\_apigw\_layer\_arn | n/a |

git remote set-url origin https://github.com/tonygyerr/terraform-aws-ec2.git