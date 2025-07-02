
provider "aws" {
  region = "eu-north-1"
}

module "vpc" {
  source = "./modules/vpc"
}

module "frontend_instance" {
  source        = "./modules/ec2"
  instance_name = "frontend"
  subnet_id     = module.vpc.public_subnet_id
  sg_id         = module.vpc.frontend_sg_id
  key_name      = var.key_name
}

module "backend_instance" {
  source        = "./modules/ec2"
  instance_name = "backend"
  subnet_id     = module.vpc.public_subnet_id
  sg_id         = module.vpc.backend_sg_id
  key_name      = var.key_name
}

module "mysql_instance" {
  source        = "./modules/ec2"
  instance_name = "mysql"
  subnet_id     = module.vpc.public_subnet_id
  sg_id         = module.vpc.mysql_sg_id
  key_name      = var.key_name
}
