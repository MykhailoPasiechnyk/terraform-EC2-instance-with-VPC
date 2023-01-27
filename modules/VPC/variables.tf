variable "name" {
  type        = string
  description = "The name of VPC"
}

variable "cidr" {
  type        = string
  description = "Cidr block for VPC"
}

variable "public_subnet_cidr" {
  type        = string
  description = "Cidr block for Public Subnet"
}

variable "tags" {
  type = map(any)
}
