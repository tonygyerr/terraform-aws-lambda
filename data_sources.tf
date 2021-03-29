data "aws_elb_service_account" "main" {}

data "aws_caller_identity" "current" {}

# data "aws_iam_role" "lambda" {
#   name = var.iam_role_name
# }
