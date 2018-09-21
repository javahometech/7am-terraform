provider "aws" {
  region = "${var.region}"
}

# VPC to host job assist application on AWS
resource "aws_vpc" "jobassist_vpc" {
  cidr_block       = "${var.vpc_cidr}"
  instance_tenancy = "${var.instance_tenancy}"

  tags {
    Name     = "JobAssistVpc"
    Location = "Banglore"
  }
}

# This is public subnets, To deploy web servers
resource "aws_subnet" "webservers" {
  count                   = "${length(data.aws_availability_zones.azs.names)}"
  vpc_id                  = "${aws_vpc.jobassist_vpc.id}"
  cidr_block              = "${var.web_cidr}"
  availability_zone       = "${data.aws_availability_zones.azs.names[count.index]}"
  map_public_ip_on_launch = true

  tags {
    Name = "PublicSubnet"
  }
}
