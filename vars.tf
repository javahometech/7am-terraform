variable "region" {
  type        = "string"
  default     = "ap-south-1"
  description = "Choose Region in which resorces should be provisioned"
}

variable "vpc_cidr" {
  type    = "string"
  default = "10.0.0.0/16"
}

variable "web_cidr" {
  type    = "string"
  default = "10.0.1.0/24"
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
