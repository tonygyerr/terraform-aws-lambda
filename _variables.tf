# -----------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# -----------------------------------------------------------------------------------------------------

variable "app_name" {
  description = "Application Name"
  default     = ""
}

variable "arguments" {
  type    = map(any)
  default = {}
}

variable "environment_variables" {
  description = "A map that defines environment variables for the Lambda Function."
  type        = map(string)
  default     = {}
}

variable "filename" {
  description = "path to the filename"
  default     = ""
}

variable "function_name" {
  description = "name of your lambda function name"
}

variable "handler" {
  default = ""
}

variable "runtime" {
  default = "python3.8"
}

variable "iam_role_arn" {
  description = "The Role"
  type        = string
  default     = ""
}

variable "iam_role_name" {
  description = "The Role Name"
  type        = string
  default     = ""
}

variable "app_tags" {
  type        = map(string)
  description = "optional lambda tags"

  default = {
    name        = ""
    owner       = ""
    costcenter  = ""
    environment = ""
    project     = ""
  }
}

# -----------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# -----------------------------------------------------------------------------------------------------

variable "description" {
  description = "Description of your Lambda Function"
  default     = ""
}

variable "environment" {}

variable "module_name" {
  type    = string
  default = ""
}

variable "memory_size" {
  default = "256"
}

variable "publish" {
  default = false
}

variable "aws_region" {
  description = "Default AWS Region"
  type        = string
  default     = ""
}

variable "profile" {
  description = "Enter name of profile"
  default     = ""
}

# variable "region" {
#   description = "ec2 region for the vpc"
#   type        = string
# }



variable "reserved_concurrent_executions" {
  default = "-1"
}

variable "extra_tags" {
  description = "A map of extra tags provided by the user"
  type        = map(string)
  default     = {}
}

variable "timeout" {
  default = 3
}

variable "vpc_config" {
  description = "Configuration options for VPC adn subnets"
  type        = map(list(string))
  default     = {}
}

variable "api_rest_api_id" {
  type    = string
  default = ""
}

variable "api_http_method" {
  type    = string
  default = ""
}

variable "api_resource_path" {
  type    = string
  default = ""
}

variable "subnet_ids" {
  default = ""
}

variable "security_group_ids" {
  default = ""
}

variable "lambda_exec_policy" {
  default = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": [ "arn:aws:logs:*:*:*" ]
        },
        {
            "Effect": "Allow",
            "Resource": "*",
            "Action": [
                "ec2:DescribeInstances",
                "ec2:CreateNetworkInterface",
                "ec2:AttachNetworkInterface",
                "ec2:DescribeNetworkInterfaces",
                "autoscaling:CompleteLifecycleAction",
                "lambda:InvokeFunction"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:PutObject",
                "s3:GetObject",
                "s3:PutObject",
                "s3:DeleteObject",
                "s3:ListBucket"
            ],
            "Resource": [ "arn:aws:s3:::*" ]
        }
    ]
}
EOF
}

variable "http_method" {
  default = ""
}

variable "lambda_path" {
  type    = string
  default = ""
}

variable "stack_name" {
  type    = string
  default = ""
}

variable "layer_name" {
  type    = string
  default = ""
}

variable "ipset_v4" {
  type    = string
  default = ""
}

variable "ipset_v6" {
  type    = string
  default = ""
}

variable "dead_letter_arn" {
  type    = string
  default = ""
}