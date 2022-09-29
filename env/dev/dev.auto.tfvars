env                 = "dev"
namespace           = "ecomv2"
cidr_block          = "172.25.0.0/16"
private_cidr_blocks = ["172.25.1.0/24", "172.25.2.0/24", "172.25.3.0/24", "172.25.4.0/24"]
public_cidr_blocks  = ["172.25.5.0/24", "172.25.6.0/24"]
availability_zone   = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d"]
lb_type             = "application"
tg = {
  laptop = {
    priority = "100"
    port     = 8081
    path     = "/laptop/*"
    hc       = "/laptop/healthz"
  },
  mobile = {
    priority = "200"
    port     = 8082
    path     = "/mobile/*"
    hc       = "/mobile/healthz"
  },
  mens-cloths = {
    priority = "300"
    port     = 8083
    path     = "/mens-cloths/*"
    hc       = "/mens-cloths/healthz"
  }
}
tags = {
  env       = "development"
  bill_unit = "zshapr-102"
  owner     = "ecom"
  mail      = "atulyw@greamio.com"
  team      = "DevOps"
}

ingress = {
  ssh = {
    port = 22
  },
  http = {
    description = "TLS from VPC"
    port        = 80

  },
  tomcat = {
    port        = 8080
    cidr_blocks = ["172.25.12.31/32"]
  }
}