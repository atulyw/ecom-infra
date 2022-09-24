variable "env" {
  type    = string
  default = "dev"
}

variable "namespace" {
  type    = string
  default = "ecom"
}

variable "cidr_block" {
  type    = string
  default = "10.0.0.0/16"
}

variable "private_cidr_blocks" {
  type    = list(any)
  default = ["10.0.24.0/21", "10.0.32.0/21", "10.0.40.0/21", "10.0.64.0/21", "10.0.56.0/21"]
}

variable "public_cidr_blocks" {
  type    = list(any)
  default = ["10.0.16.0/21", "10.0.48.0/21"]
}

variable "availability_zone" {
  type    = list(any)
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "map_public_ip_on_launch" {
  type    = bool
  default = true
}

variable "tags" {
  type = map(string)
  default = {
    env       = "development"
    bill_unit = "zshapr-102"
    owner     = "ecom"
    mail      = "atulyw@greamio.com"
    team      = "DevOps"
  }
}