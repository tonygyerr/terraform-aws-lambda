# data "aws_iam_role" "lambda" {
#   name = var.iam_role_name
# }

data "aws_sqs_queue" waf" {
  name = "service-deadletter-queue"
}