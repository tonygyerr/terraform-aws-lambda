data "archive_file" "service" {
  type        = "zip"
  source_dir  = "${path.module}/src"
  output_path = "${path.module}/src/out/thumbnail.zip"
}

module "lambda" {
  source = "git::ssh://git@github.com:tonygyerr/terraform-aws-lambda.git"
  # source  = "../"
  api_rest_api_id        = var.api_rest_api_id
  api_http_method        = var.api_http_method
  api_resource_path      = var.api_resource_path
  region                 = var.aws_region
  environment            = var.environment
  filename               = data.archive_file.service.output_path #data.archive_file.this.output_base64sha256
  application            = var.application
  lambda_path            = var.lambda_path
  layer_name             = var.layer_name
  function_name          = var.function_name
  stack_name             = var.stack_name
  iam_role_arn           = var.iam_role_arn #data.aws_iam_role.lambda.arn
}
