# storing-stack

Terraform stack for storing files for the `file-processing` project. It
deploys an S3 bucket (via the [`modules/s3`](../../modules/s3) module) with
versioning, default encryption and public access blocking, plus a CloudWatch
log group (via the [`modules/cloudwatch`](../../modules/cloudwatch) module) to
collect application logs.

## Structure

```
stacks/storing-stack/
├── main.tf                    # Module invocation and tag composition
├── outputs.tf                 # Stack outputs
├── providers.tf               # AWS provider
├── variables.tf               # Stack variables
├── versions.tf                # Terraform / provider / backend versions
├── terraform.tfvars.example   # Example tfvars
└── README.md
```

## Resources

| Resource                        | Description                                   |
| ------------------------------- | --------------------------------------------- |
| `aws_s3_bucket.this`            | Project S3 bucket                             |
| `aws_s3_bucket_versioning.this` | Bucket versioning (enabled by default)       |
| `aws_s3_bucket_server_side_encryption_configuration.this` | AES256 encryption |
| `aws_s3_bucket_public_access_block.this` | Public access blocking                |
| `aws_cloudwatch_log_group.this` | CloudWatch log group for application logs     |

## Tags

Tags are composed automatically from the stack variables:

- `Environment` ← `var.environment`
- `CostCenter` ← `var.cost_center`
- `Project` ← `var.project`
- `map-migrated` ← `var.map-migrated`
- `Owner` ← `var.owner`
- `ManagedBy` → `Terraform` (fixed)
- `Name` → resource name (added by each module)

Only tags with a **non-empty** value are included. The `tags` variable lets
you add extra tags and **override** any computed tag.

## Variables

| Variable               | Type          | Required | Default     | Description                                        |
| ---------------------- | ------------- | -------- | ----------- | -------------------------------------------------- |
| `bucket_name`          | `string`      | **yes**  | —           | S3 bucket name                                     |
| `log_group_name`       | `string`      | **yes**  | —           | CloudWatch log group name                          |
| `log_retention_in_days`| `number`      | no       | `30`        | Log retention in days (`0` = keep forever)        |
| `region`               | `string`      | no       | `eu-west-1` | Primary AWS region                                 |
| `environment`          | `string`      | no       | `""`        | Environment name (`Environment` tag)               |
| `cost_center`          | `string`      | no       | `""`        | Cost center (`CostCenter` tag)                     |
| `project`              | `string`      | no       | `""`        | Project name (`Project` tag)                       |
| `map-migrated`         | `string`      | no       | `""`        | AWS SMS server ID (`map-migrated` tag)             |
| `owner`                | `string`      | no       | `""`        | Owner (`Owner` tag)                                |
| `tags`                 | `map(string)` | no       | `{}`        | Extra / override tags                              |
| `versioning_enabled`   | `bool`        | no       | `true`      | Enable bucket versioning                           |

## Outputs

| Output          | Description                          |
| --------------- | ------------------------------------ |
| `bucket_id`     | S3 bucket ID                         |
| `bucket_arn`    | S3 bucket ARN                        |
| `bucket_name`   | S3 bucket name                       |
| `bucket_tags`   | Map of tags applied to the bucket    |
| `log_group_name`| CloudWatch log group name            |
| `log_group_arn` | CloudWatch log group ARN             |
| `log_group_tags`| Map of tags applied to the log group |

## Usage

From this folder:

```bash
# 1. Set configuration values
cp terraform.tfvars.example terraform.tfvars
# edit terraform.tfvars with your values

# 2. Initialize (downloads providers)
terraform init

# 3. Preview
terraform plan

# 4. Apply
terraform apply

# 5. View outputs
terraform output
```

> **Note**: The S3 backend declared in `versions.tf` is configured through
> `-backend-config` or `terraform init -backend-config=...`. Without a
> configured backend, `terraform init` will use the local backend.