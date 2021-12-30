resource "aws_cloudwatch_event_rule" "this" {
  depends_on          = [aws_lambda_function.this]
  name                = "app-event-${var.app_name}"
  description         = "Trigger Lambda"
  schedule_expression = "cron(52 17 20 12 ? 2020)"
  is_enabled          = true
}
