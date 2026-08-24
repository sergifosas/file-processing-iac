# file-processing-iac

IaC for the file-processing project.

## Repository

```
├── modules/
│   └── s3/
│       ├── main.tf          S3 module (bucket + versioning + encryption + public access block)
│       ├── variables.tf
│       └── outputs.tf
└── stacks/
    └── storing-stack/       File storage stack
        ├── main.tf
        ├── variables.tf
        ├── outputs.tf
        ├── providers.tf
        ├── versions.tf
        ├── terraform.tfvars.example
        └── README.md
```

## Quickstart

```bash
cd stacks/storing-stack
cp terraform.tfvars.example terraform.tfvars
terraform init
terraform apply
```

See the documentation of each stack in its own `README.md`.

## CI / GitHub Actions

`.github/workflows/ci.yml` runs on every push to `main`/`feature/*` and on
pull requests targeting `main` (also available via `workflow_dispatch`).

| Job                   | Command                                                            |
| --------------------- | ------------------------------------------------------------------ |
| `fmt`                 | `terraform fmt -check -recursive` across the whole repository    |
| `validate`            | `terraform init -backend=false` + `terraform validate` for each stack/module |