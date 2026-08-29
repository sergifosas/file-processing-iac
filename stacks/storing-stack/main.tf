locals {
  tags = merge(
    var.tags,
    {
      for k, v in {
        Environment    = var.environment
        CostCenter     = var.cost_center
        Project        = var.project
        "map-migrated" = var.map-migrated
        Owner          = var.owner
        ManagedBy      = "Terraform"
      } : k => v if v != ""
    }
  )
}

module "file_storage" {
  source = "../../modules/s3"

  bucket_name        = var.bucket_name
  versioning_enabled = var.versioning_enabled
  tags               = local.tags
}

module "cloudwatch_logs" {
  source = "../../modules/cloudwatch"

  log_group_name    = var.log_group_name
  retention_in_days = var.log_retention_in_days
  tags              = local.tags
}


module "cognito" {
  source = "../../modules/cognito"

  user_pool_name  = var.user_pool_name
  app_client_name = var.app_client_name
  
  test_user_email   = var.test_user_email
  test_user_password = var.test_user_password

  tags            = local.tags
}
