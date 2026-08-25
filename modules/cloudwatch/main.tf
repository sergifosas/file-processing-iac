resource "aws_cloudwatch_log_group" "this" {
  name              = var.log_group_name
  retention_in_days = var.retention_in_days
  kms_key_id        = var.kms_key_id

  tags = merge(
    var.tags,
    {
      Name = var.log_group_name
    }
  )
}
  