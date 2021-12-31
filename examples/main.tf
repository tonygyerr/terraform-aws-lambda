data "archive_file" "service" {
  type        = "zip"
  source_dir  = "${path.module}/src"
  output_path = "${path.module}/src/out/thumbnail.zip"
}

module "lambda" {
  source                = "git::https://github.com/tonygyerr/terraform-aws-lambda.git"
  region                = var.aws_region
  environment           = var.environment
  environment_variables = merge(local.lambda_arguments, var.arguments)
  filename              = data.archive_file.service.output_path #data.archive_file.this.output_base64sha256
  app_name              = var.app_name
  handler               = var.handler
  lambda_path           = var.lambda_path
  layer_name            = var.layer_name
  profile               = var.profile
  function_name         = var.function_name
  stack_name            = var.stack_name
  iam_role_arn          = var.iam_role_arn #data.aws_iam_role.lambda.arn
}
