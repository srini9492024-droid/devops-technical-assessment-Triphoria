# DevOps Infrastructure & Automation Assessment

This repository contains the complete solution for the DevOps Assessment, featuring a local automated database layer and a modular, multi-environment AWS cloud architecture built using Terraform.

## Project Structure
* `/database` - Contains the foundational `init.sql` schema and mock dataset.
* `/scripts` - Contains cross-platform, volume-isolated backup and restoration automation shell scripts.
* `/infra/modules` - Reusable architectural blueprints for AWS Networking, RDS, and ECS Compute layers.
* `/infra/envs` - Root execution environments separating `dev` and `prod` logic.
* `/.github/workflows` - Automated CI/CD validation pipeline.

## Getting Started: Local Database Automation

### Prerequisites
* Docker & Docker Compose
* Git Bash (for Windows environments)

### Initialize the Container Data Layer
```bash
docker compose up -d
docker exec -i local_postgres psql -U devops_user -d booking_db < database/init.sql

```

### Architecture & Design Decisions

### 1. Traffic Flow & Security Boundary
The AWS infrastructure strictly enforces the requested privacy constraints:
* **Public Tier:** The Application Load Balancer (ALB) sits in the public subnets to receive internet traffic.
* **Compute Tier:** ECS Fargate tasks reside in private subnets and only accept traffic forwarded by the ALB.
* **Data Tier:** The RDS PostgreSQL instance is deployed in isolated private subnets. Its security group strictly allows inbound connections *only* from the ECS containers on port 5432.

### 2. Cross-Platform Database Automation
To ensure the local database scripts work flawlessly across Windows (Git Bash) and Linux environments, the backup strategy utilizes volume-isolated binary dumps. By executing `pg_dump -F c` to a temporary internal container directory and extracting it via `docker cp`, the automation completely bypasses Windows line-ending corruption and path-translation errors.

### 3. Terraform State & Execution
As per the assessment guidelines, the infrastructure is designed for a `plan-only` demonstration. The Terraform providers are configured with mock credentials (`skip_credentials_validation = true`) to allow reviewers to run local validation and planning without requiring an active AWS account.