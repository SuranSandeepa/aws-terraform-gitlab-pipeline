#root

module "vpc" {
  source = "./vpc"
}

module "ec2" {
  source = "./web"
  public_subnet_id = module.vpc.public_subnet
  security_group_id = module.vpc.public_sg
}

