#--------------------------------------------------------------
# inputs
#--------------------------------------------------------------

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| account\_id |  | string | `"11111111111111111"` | no |
| api\_http\_method |  | string | n/a | yes |
| api\_resource\_path |  | string | n/a | yes |
| api\_rest\_api\_id |  | string | n/a | yes |
| application |  | string | n/a | yes |
| aws\_region | ec2 region for the vpc | string | `"us-east-1"` | no |
| cost\_center |  | string | `"N/A"` | no |
| environment |  | string | n/a | yes |
| iam\_role\_main |  | string | n/a | yes |
| lambda\_path |  | string | n/a | yes |
| layer\_name |  | string | n/a | yes |
| owner |  | string | `"user@emailaddress.com"` | no |
| stack\_name |  | string | n/a | yes |
| stage\_name |  | string | n/a | yes |
| swagger\_function\_name |  | string | n/a | yes |

#--------------------------------------------------------------
# outputs
#--------------------------------------------------------------

| Name | Description |
|------|-------------|
| lambda\_alexa\_arn |  |
| lambda\_alexa\_layer\_arn |  |
| lambda\_alexa\_name |  |
| lambda\_apigw\_alexa\_arn |  |
| lambda\_apigw\_alexa\_layer\_arn |  |
| lambda\_apigw\_alexa\_name |  |
| lambda\_apigw\_dynamodb\_arn |  |
| lambda\_apigw\_dynamodb\_name |  |
| lambda\_apigw\_lex\_arn |  |
| lambda\_apigw\_lex\_name |  |
| lambda\_apigw\_rekognition\_arn |  |
| lambda\_apigw\_rekognition\_name |  |
| lambda\_dynamodb\_arn |  |
| lambda\_dynamodb\_layer\_arn |  |
| lambda\_dynamodb\_name |  |
| lambda\_lex\_arn |  |
| lambda\_lex\_name |  |
| lambda\_lex\_version |  |
| lambda\_rekognition\_arn |  |
| lambda\_rekognition\_layer\_arn |  |
| lambda\_rekognition\_name |  |

## Terraform Module
```terraform
module "lambda" {
  source = "git::ssh://git@github.com:tonygyerr/terraform-aws-lambda.git"
  api_rest_api_id        = var.api_rest_api_id
  api_http_method        = var.api_http_method
  api_resource_path      = var.api_resource_path
  region                 = var.aws_region
  environment            = var.environment
  application            = var.application
  lambda_path            = var.lambda_path
  layer_name             = var.layer_name
  function_name          = var.function_name
  stack_name             = var.stack_name
  iam_role_arn           = var.iam_role_arn
}
```