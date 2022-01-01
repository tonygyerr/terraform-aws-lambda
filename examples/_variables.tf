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

variable "filename" {
  description = "path to the filename"
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

variable "handler" {
  default = ""
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

variable "region" {
  type = string
  # default     = ""
}


variable "iam_role_arn" {
  type = string
}

variable "iam_role_name" {
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

variable "ipset_v4" {
  type    = string
  default = ""
}

variable "ipset_v6" {
  type    = string
  default = ""
}

variable "logging_bucket" {
  description = ""
  default     = ""
}


variable "dead_letter_arn" {
  type    = string
  default = ""
}

variable "scope" {
  type    = string
  default = ""
}

variable "kms_master_key_id" {
  type    = string
  default = null
}

variable "errorThreshold" {
  description = "If you chose yes for the Activate Scanners & Probes Protection parameter, enter the maximum acceptable bad requests per minute per IP. If you chose to deactivate this protection protection, ignore this parameter."
  type = number
  default = 50
}

variable "blockPeriod" {
  description = "If you chose yes for the Activate Scanners & Probes Protection or HTTP Flood Lambda/Athena log parser parameters, enter the period (in minutes) to block applicable IP addresses. If you chose to deactivate log parsing, ignore this parameter."
  type        = number
  default     = 240
}