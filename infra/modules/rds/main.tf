# 1. DB Subnet Group (Forces the DB into our Private Subnets)
resource "aws_db_subnet_group" "main" {
  name       = "booking-db-subnet-group-${var.environment}"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "Booking DB Subnet Group ${var.environment}"
  }
}

# 2. RDS PostgreSQL Instance
resource "aws_db_instance" "postgres" {
  identifier = "booking-db-${var.environment}"
  
  # Engine specifications matching our local Docker setup
  engine               = "postgres"
  engine_version       = "16.1"
  
  # Dynamic Variables mapped to environments
  instance_class          = var.instance_class
  backup_retention_period = var.backup_retention_period
  deletion_protection     = var.deletion_protection

  # Storage Configurations
  allocated_storage     = 20
  max_allocated_storage = 100
  storage_type          = "gp3"

  # Database Credentials (In a real scenario, use AWS Secrets Manager!)
  db_name  = "booking_db"
  username = "devops_user"
  password = "secure_password123!" 

  # Network & Security
  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [var.rds_sg_id]
  publicly_accessible    = false 
  skip_final_snapshot    = true  

  tags = {
    Environment = var.environment
  }
}