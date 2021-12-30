output "lambda_function_name" {
  value = "${module.lambda.lambda_function_name}"
}

output "lambda_arn" {
  value = "${module.lambda.lambda_arn}"
}

output "lambda_invoke_arn" {
  value = "${module.lambda.lambda_invoke_arn}"
}

output "lambda_permission_apigw_layer_arn" {
  value = "${module.lambda.lambda_permission_apigw_layer_arn}"
}