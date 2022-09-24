
module "dev_vpc" {
  source              = "../../modules/vpc"
  env                 = "dev"
  namespace           = "ecom"
  cidr_block          = "172.25.0.0/16"
  private_cidr_blocks = ["172.25.1.0/24", "172.25.2.0/24", "172.25.3.0/24", "172.25.4.0/24"]
  public_cidr_blocks  = ["172.25.5.0/24", "172.25.6.0/24"]
  availability_zone   = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d"]
  tags = {
    env       = "development"
    bill_unit = "zshapr-102"
    owner     = "ecom"
    mail      = "atulyw@greamio.com"
    team      = "DevOps"
  }
}

module "test_vpc" {
  source              = "../../modules/vpc"
  env                 = "test"
  namespace           = "ecom"
  cidr_block          = "172.26.0.0/16"
  private_cidr_blocks = ["172.26.1.0/24", "172.26.2.0/24", "172.26.3.0/24", "172.26.4.0/24"]
  public_cidr_blocks  = ["172.26.5.0/24", "172.26.6.0/24"]
  availability_zone   = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d"]
  tags = {
    env       = "test"
    bill_unit = "zshapr-102"
    owner     = "ecom"
    mail      = "atulyw@greamio.com"
    team      = "DevOps"
  }
}