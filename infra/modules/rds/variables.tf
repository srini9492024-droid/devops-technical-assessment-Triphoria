variable "environment" {
  description = "The deployment environment (e.g., dev, prod)"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs for the DB Subnet Group"
  type        = list(string)
}

variable "rds_sg_id" {
  description = "Security Group ID for the RDS instance"
  type        = string
}

variable "instance_class" {
  description = "The RDS instance class (e.g., db.t3.micro, db.m5.large)"
  type        = string
}

variable "backup_retention_period" {
  description = "How many days to retain backups"
  type        = number
}

variable "deletion_protection" {
  description = "Whether to enable deletion protection"
  type        = bool
}