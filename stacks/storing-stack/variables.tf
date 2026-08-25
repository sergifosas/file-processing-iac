variable "bucket_name" {
  description = "Name of the S3 bucket to create"
  type        = string
}

variable "log_group_name" {
  description = "Name of the CloudWatch log group to create"
  type        = string
}

variable "log_retention_in_days" {
  description = "Number of days to retain CloudWatch log events (0 keeps them forever)"
  type        = number
  default     = 30
}

variable "tags" {
  description = "External tags map merged over the computed defaults"
  type        = map(string)
  default     = {}
}

variable "region" {
  description = "Set the primary region"
  type        = string
  default     = "eu-west-1"
}

variable "environment" {
  description = "Set environment name"
  type        = string
  default     = ""
}

variable "cost_center" {
  description = "Cost center associated with the project"
  type        = string
  default     = ""
}

variable "project" {
  description = "Project name"
  type        = string
  default     = ""
}

variable "map-migrated" {
  description = "AWS Server Migration Service tag 'map-migrated' server ID"
  type        = string
  default     = ""
}

variable "owner" {
  description = "Owner name (internal)"
  type        = string
  default     = ""
}

variable "versioning_enabled" {
  description = "Enable S3 bucket versioning on the stack"
  type        = bool
  default     = true
}
