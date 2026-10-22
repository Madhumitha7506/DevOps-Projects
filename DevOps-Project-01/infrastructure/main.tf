terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {}
}

provider "aws" {
  region = "eu-north-1"
}

module "vpc" {
  source = "./modules/vpc"
  vpc_cidr        = var.vpc_cidr
  environment     = var.environment
  public_subnets  = var.public_subnet_cidrs
  private_subnets = var.private_subnet_cidrs
  azs             = var.availability_zones
}

module "security" {
  source = "./modules/security"
  vpc_id      = module.vpc.vpc_id
  environment = var.environment
}

resource "aws_instance" "bastion" {
  ami                         = "ami-0014ce3e52359afbd"
  instance_type               = "t3.micro"
  subnet_id                   = module.vpc.public_subnet_ids[0]
  vpc_security_group_ids      = [module.security.bastion_security_group_id]
  key_name                    = var.key_name
  associate_public_ip_address = true
  tags = {
    Name        = "${var.environment}-bastion"
    Environment = var.environment
  }
}

module "rds" {
  source = "./modules/rds"
  environment         = var.environment
  vpc_id              = module.vpc.vpc_id
  subnet_ids          = module.vpc.private_subnet_ids
  db_username         = var.db_username
  db_password         = var.db_password
  security_group_ids  = [module.security.db_security_group_id]
}

module "alb" {
  source = "./modules/alb"
  environment     = var.environment
  vpc_id          = module.vpc.vpc_id
  security_groups = [module.security.alb_security_group_id]
  public_subnets  = module.vpc.public_subnet_ids
}

module "asg" {
  source = "./modules/asg"
  environment         = var.environment
  vpc_id              = module.vpc.vpc_id
  private_subnet_ids  = module.vpc.private_subnet_ids
  target_group_arns   = [module.alb.target_group_arn]
  security_group_ids  = [module.security.app_security_group_id]
  key_name            = var.key_name
  instance_type       = "t3.micro"
}
