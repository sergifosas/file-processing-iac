output "log_group_arn" {
  description = "CloudWatch log group ARN"
  value       = aws_cloudwatch_log_group.this.arn
}

output "log_group_name" {
  description = "CloudWatch log group name"
  value       = aws_cloudwatch_log_group.this.name
}

output "log_group_tags" {
  description = "All tags applied to the CloudWatch log group"
  value       = aws_cloudwatch_log_group.this.tags_all
}
