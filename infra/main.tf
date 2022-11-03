terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 4.27.0"
    }
  }

  required_version = ">= 1.2.5"
}

provider "aws" {
  region = var.aws-region
}



module "vpc" {
  source              = "./vpc"
  name                = var.name
  environment         = var.environment
  cidr                = var.cidr
  private_subnets     = var.private_subnets
  public_subnets      = var.public_subnets
  availability_zones  = var.availability_zones
}

module "alb" {
  source              = "./alb"
  name                = var.name
  environment         = var.environment
  vpc_id              = module.vpc.id
  subnets             = module.vpc.public_subnets
  alb_tls_cert_arn    = module.r53.tls_certificate
  health_check_path   = var.health_check_path
}

module "ecr" {
  source      = "./ecr"
  name        = var.name
  environment = var.environment
}

module "efs" {
  source              = "./efs"
  name                = var.name
  environment         = var.environment
  private_subnets     = module.vpc.private_subnets
  vpc_id              = module.vpc.id
}

module "ecs" {
  source                      = "./ecs"
  name                        = var.name
  environment                 = var.environment
  region                      = var.region
  vpc_id                      = module.vpc.id
  subnets                     = module.vpc.private_subnets
  aws_alb_target_group_arn    = module.alb.aws_alb_target_group_arn
  container_image             = module.ecr.repository_url
  container_port              = var.container_port
  container_cpu               = var.container_cpu
  container_memory            = var.container_memory
  desired_tasks               = var.desired_tasks
  efs_fs_id                   = module.efs.efs_fs_id
  efs_ap_id                   = module.efs.efs_ap_id
  container_environment       = [{ name = "EFS_PATH", value = "/efs" }, { name = "PORT", value = var.container_port }]
}

module "r53" {
  source        = "./r53"
  name          = var.name
  environment   = var.environment
  domain        = var.domain
  alb_zone_id   = module.alb.zone_id
  alb_dns_name  = module.alb.dns_name
}

output "domain" {
    value = var.domain
}

output "aws_ecr_repository_url" {
    value = module.ecr.repository_url
}

output "aws_alb_dns_name" {
    value = module.alb.dns_name
}

