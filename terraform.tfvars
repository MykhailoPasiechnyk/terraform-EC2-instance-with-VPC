#-------------Provider AWS---------------------
aws_region = "eu-central-1"

#-------------Module VPC-----------------------
vpc_name           = "dev-vpc"
vpc_cidr           = "10.0.0.0/16"
public_subnet_cidr = "10.0.101.0/24"

#-------------Module EC2_Instance--------------
ec2_name      = "dev-flask-instance"
ami           = "ami-0a261c0e5f51090b1"
instance_type = "t2.micro"
monitoring    = false

#-------------Tags-----------------------------
tags = {
  Terraform   = "true"
  Environment = "dev"
}
