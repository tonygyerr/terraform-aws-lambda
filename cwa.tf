resource "aws_cloudwatch_event_rule" "this" {
  depends_on          = [aws_lambda_function.this]
  name                = "app-event-${var.app_name}-${var.function_name}"
  description         = "Trigger Lambda"
  schedule_expression = "rate(1 hour)"
  is_enabled          = true
}

resource "aws_cloudwatch_log_group" "this" {
  name              = "/aws/lambda/${var.app_name}-${var.function_name}"
  retention_in_days = 30
}

resource "aws_cloudwatch_event_target" "this" {
  rule = aws_cloudwatch_event_rule.this.name
  arn  = aws_lambda_function.this.*.arn
}