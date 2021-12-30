variable "app_name" {
  description = "Application Name"
  default     = ""
}

variable "environment" {
}

variable "environment_variables" {
  description = "A map that defines environment variables for the Lambda Function."
  type        = map(string)
  default     = {}
}

variable "arguments" {
  type        = map
  default     = {}
}

variable "filename" {
  description = "path to the filename"
  default     = ""
}

variable "arguments" {
  type        = map
  default     = {}
}

variable "environment_variables" {
  description = "A map that defines environment variables for the Lambda Function."
  type        = map(string)
  default     = {}
}

variable "handler" {
  default = ""
}

variable "cost_center" {
  type    = string
  default = "N/A"
}

variable "owner" {
  type    = string
  default = "user@emailaddress.com"
}

variable "aws_region" {
  description = "ec2 region for the vpc"
  type        = string
  default     = "us-east-1"
}

variable "account_id" {
  type    = string
}

variable "iam_role_arn" {
  type = string
}

variable "iam_role_name" {
  type = string
}

variable "api_rest_api_id" {
  type = string
}

variable "api_http_method" {
  type = string
}

variable "api_resource_path" {
  type = string
}

variable "lambda_path" {
  type = string
}

variable "stack_name" {
  type = string
}

variable "function_name" {
  type = string
}

variable "layer_name" {
  type = string
}
