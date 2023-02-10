provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source = "./modules/VPC"

  name               = var.vpc_name
  cidr               = var.vpc_cidr
  public_subnet_cidr = var.public_subnet_cidr
  tags               = var.tags
}

module "security_group" {
  source = "./modules/ASG"

  vpc_id = module.vpc.vpc_id
  tags   = var.tags
}

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name                   = var.ec2_name
  ami                    = var.ami
  instance_type          = var.instance_type
  monitoring             = var.monitoring
  vpc_security_group_ids = [module.security_group.sg_id]
  subnet_id              = module.vpc.public_subnet_id
  key_name               = var.key_name
  user_data              = file("user_data.sh")
  tags                   = var.tags
}

module "cpu_80_util_email" {
  source = "./modules/cloud_watch_cpu_util"

  email  = var.email
  ec2_id = module.ec2_instance.id
}
