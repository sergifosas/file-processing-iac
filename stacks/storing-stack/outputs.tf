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
