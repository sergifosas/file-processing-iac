
variable "log_group_name" {
  description = "Name of the CloudWatch log group"
  type        = string
}

variable "retention_in_days" {
  description = "Number of days to retain log events (0 keeps them indefinitely)"
  type        = number
  default     = 30
}

variable "kms_key_id" {
  description = "ARN of the KMS key used to encrypt the log group (null defaults to the AWS managed key)"
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags applied to the CloudWatch log group"
  type        = map(string)
  default     = {}
}
