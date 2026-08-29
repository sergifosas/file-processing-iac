variable "user_pool_name" {
  description = "Name of the Cognito User Pool"
  type        = string
}

variable "app_client_name" {
  description = "Name of the Cognito App Client"
  type        = string
}

variable "test_user_email" {
  description = "Email of the test Cognito user"
  type        = string
}

variable "test_user_password" {
  description = "Temporary password of the test Cognito user"
  type        = string
  sensitive   = true
}

variable "tags" {
  description = "Tags applied to Cognito resources"
  type        = map(string)
  default     = {}
}
