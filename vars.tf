variable "region" {
  type        = "string"
  default     = "ap-south-1"
  description = "Choose Region in which resorces should be provisioned"
}

variable "vpc_cidr" {
  type    = "string"
  default = "10.0.0.0/16"
}

variable "web_cidrs" {
  type    = "list"
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "db_cidrs" {
  type    = "list"
  default = ["10.0.7.0/24", "10.0.8.0/24"]
}

# Declare the data source
data "aws_availability_zones" "azs" {}

variable "web_az" {
  default = "ap-south-1a"
}

variable "instance_tenancy" {
  type    = "string"
  default = "default"
}

variable "auto_assign_public_ip" {
  default = true
}

variable "web_ami" {
  type = "map"

  default = {
    ap-south-1 = "ami-00b6a8a2bd28daf19"
    us-east-1  = "ami-0ff8a91507f77f867"
  }
}

variable "instance_type" {
  default = "t2.micro"
}
