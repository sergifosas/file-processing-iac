output "bucket_id" {
  description = "ID of the S3 bucket"
  value       = module.file_storage.bucket_id
}

output "bucket_arn" {
  description = "ARN of the S3 bucket"
  value       = module.file_storage.bucket_arn
}

output "bucket_name" {
  description = "Name of the S3 bucket"
  value       = module.file_storage.bucket_name
}

output "bucket_tags" {
  description = "All tags applied to the S3 bucket"
  value       = module.file_storage.bucket_tags
}

output "log_group_name" {
  description = "Name of the CloudWatch log group"
  value       = module.cloudwatch_logs.log_group_name
}

output "log_group_arn" {
  description = "ARN of the CloudWatch log group"
  value       = module.cloudwatch_logs.log_group_arn
}

output "log_group_tags" {
  description = "All tags applied to the CloudWatch log group"
  value       = module.cloudwatch_logs.log_group_tags
}

output "cognito_user_pool_id" {
  value = module.cognito.user_pool_id
}

output "cognito_user_pool_arn" {
  value = module.cognito.user_pool_arn
}

output "cognito_user_pool_endpoint" {
  value = module.cognito.user_pool_endpoint
}

output "cognito_app_client_id" {
  value = module.cognito.app_client_id
}
