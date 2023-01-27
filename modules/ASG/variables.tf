variable "vpc_id" {
  type        = string
  description = "VPC id"
}

variable "tags" {
  type = map(any)
}
