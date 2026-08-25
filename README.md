# file-processing-iac

IaC for the file-processing project.

## Repository

```
├── modules/
│   ├── s3/
│   │   ├── main.tf          S3 module (bucket + versioning + encryption + public access block)
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── cloudwatch/
│       ├── main.tf          CloudWatch module (log group with retention + encryption)
│       ├── variables.tf
│       └── outputs.tf
└── stacks/
    └── storing-stack/       File storage + logging stack
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

## Local development with LocalStack

[LocalStack](https://docs.localstack.cloud) lets you run AWS services locally via
Docker, so you can deploy and test the Terraform infrastructure without touching
real AWS. All the stacks are wired to `http://localhost:4566` when running
locally (see the `providers.tf` of each stack).

### 1. Start LocalStack

Make sure [Docker](https://www.docker.com) is installed and running, then boot
the container from the repository root:

```bash
docker compose up -d
```

This starts LocalStack on `http://localhost:4566`. Local state is persisted in
the `localstack-data/` folder (kept out of version control).

### 2. Check that LocalStack is healthy

On **Windows / PowerShell** the terminal cannot open a URL directly, so use
`Invoke-WebRequest` or `curl`:

```powershell
Invoke-WebRequest http://localhost:4566/_localstack/info
```

```bash
curl http://localhost:4566/_localstack/info
```

A `200` response with a JSON body (e.g. `{"version":"4.10.0",...}`) means
LocalStack is up and ready. You can also open `http://localhost:4566/_localstack/info`
in a browser.

### 3. Deploy the infrastructure with Terraform

`stacks/storing-stack/providers.tf` already points the AWS provider at
`http://localhost:4566` and uses dummy credentials, so **no extra setup is
needed** for a local deploy.

```bash
cd stacks/storing-stack
cp terraform.tfvars.example terraform.tfvars
# The example values work out of the box; edit them if needed.

# Download providers (tfstate is stored locally via the default backend).
terraform init

# Review what will be created.
terraform plan -var-file="terraform.tfvars"

# Create the resources in LocalStack.
terraform apply -var-file="terraform.tfvars"
```

> **Note**: `versions.tf` declares an S3 backend for remote tfstate, but since it
> is not configured it falls back to the local backend. See the stack README for
> more details.

### 4. Verify the resources

View the stack outputs produced by Terraform:

```bash
terraform output
```

Or list the buckets directly against the LocalStack endpoint with the AWS CLI
(dummy credentials are enough):

```bash
aws --endpoint-url http://localhost:4566 s3 ls
```

### 5. Stop / reset

Stop the container (data is kept in `localstack-data/`):

```bash
docker compose down
```

To start completely fresh, also delete the local state:

```powershell
docker compose down
Remove-Item -Recurse -Force localstack-data
```

## CI / GitHub Actions

`.github/workflows/ci.yml` runs on every push to `main`/`feature/*` and on
pull requests targeting `main` (also available via `workflow_dispatch`).

| Job                   | Command                                                            |
| --------------------- | ------------------------------------------------------------------ |
| `fmt`                 | `terraform fmt -check -recursive` across the whole repository    |
| `validate`            | `terraform init -backend=false` + `terraform validate` for each stack/module |