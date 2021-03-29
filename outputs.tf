output "lambda_function_name" {
  value = "${aws_lambda_function.this.*.function_name}"
}

output "lambda_arn" {
  value = "${aws_lambda_function.this.*.arn}"
}

output "lambda_invoke_arn" {
  value = "${aws_lambda_function.this.*.invoke_arn}"
}

output "lambda_permission_apigw_layer_arn" {
  value = "${aws_lambda_permission.this.*.source_arn}"
}
