module "network" {
  source      = "../../modules/network"
  environment = var.environment
  vpc_cidr    = "10.1.0.0/16"
}

module "rds" {
  source                  = "../../modules/rds"
  environment             = var.environment
  private_subnet_ids      = module.network.private_subnet_ids
  rds_sg_id               = module.network.rds_sg_id
  instance_class          = var.rds_instance_class
  backup_retention_period = var.rds_backup_retention
  deletion_protection     = var.rds_deletion_protection
}

module "ecs" {
  source             = "../../modules/ecs"
  environment        = var.environment
  vpc_id             = module.network.vpc_id
  public_subnet_ids  = module.network.public_subnet_ids
  private_subnet_ids = module.network.private_subnet_ids
  alb_sg_id          = module.network.alb_sg_id
  ecs_sg_id          = module.network.ecs_sg_id
}