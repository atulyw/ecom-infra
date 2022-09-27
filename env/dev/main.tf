
module "dev_vpc" {
  source              = "../../modules/vpc"
  env                 = var.env
  namespace           = var.namespace
  cidr_block          = var.cidr_block
  private_cidr_blocks = var.private_cidr_blocks
  public_cidr_blocks  = var.public_cidr_blocks
  availability_zone   = var.availability_zone
  tags                = var.tags
}

module "lb" {
  source          = "../../modules/lb"
  env             = var.env
  namespace       = var.namespace
  lb_type         = var.lb_type
  security_groups = [module.sg.security_group_id]
  subnets         = module.dev_vpc.public_subnet
  vpc_id          = module.dev_vpc.vpc_id
  tg              = var.tg
}


module "sg" {
  source    = "../../modules/sg"
  env       = var.env
  namespace = var.namespace
  vpc_id    = module.dev_vpc.vpc_id
  ingress   = var.ingress
  tags      = var.tags
}