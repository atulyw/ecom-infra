variable "env" {
  type = string
}

variable "namespace" {
  type = string
}

variable "cidr_block" {
  type = string
}

variable "private_cidr_blocks" {
  type = list(any)
}

variable "public_cidr_blocks" {
  type = list(any)
}

variable "availability_zone" {
  type = list(any)
}

variable "map_public_ip_on_launch" {
  type    = bool
  default = true
}

variable "tags" {
  type    = map(string)
  default = {}
}