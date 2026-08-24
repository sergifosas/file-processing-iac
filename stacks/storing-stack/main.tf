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