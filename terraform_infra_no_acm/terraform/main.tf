
provider "aws" {
  region = "ap-south-2"
}

module "frontend" {
  source               = "./modules/ec2-asg-lb"
  name                 = "frontend"
  ami_id               = "ami-xyz"
  instance_type        = "t3.large"
  subnet_ids           = var.subnet_ids
  vpc_id               = var.vpc_id
  security_group_id    = aws_security_group.allow_tls.id
  key_name             = var.key_name
}

module "backend" {
  source               = "./modules/ec2-asg-lb"
  name                 = "backend"
  ami_id               = "ami-xyz"
  instance_type        = "t3.large"
  subnet_ids           = var.subnet_ids
  vpc_id               = var.vpc_id
  security_group_id    = aws_security_group.allow_tls.id
  key_name             = var.key_name
}

module "mysql" {
  source               = "./modules/ec2-asg-lb"
  name                 = "mysql"
  ami_id               = "ami-xyz"
  instance_type        = "t3.large"
  subnet_ids           = var.subnet_ids
  vpc_id               = var.vpc_id
  security_group_id    = aws_security_group.allow_tls.id
  key_name             = var.key_name
}
