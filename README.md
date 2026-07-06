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

### 1. Initialize the Container Data Layer
```bash
docker compose up -d
docker exec -i local_postgres psql -U devops_user -d booking_db < database/init.sql