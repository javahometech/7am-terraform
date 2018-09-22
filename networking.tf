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
  cidr_block              = "${var.web_cidrs[count.index]}"
  availability_zone       = "${data.aws_availability_zones.azs.names[count.index]}"
  map_public_ip_on_launch = "${var.auto_assign_public_ip}"

  tags {
    Name = "PublicSubnet-${count.index + 1}"
  }
}

# Create Internet Gateway

resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.jobassist_vpc.id}"

  tags {
    Name = "jobassist_igw"
  }
}

# Create Route table for webservers
resource "aws_route_table" "web_rt" {
  vpc_id = "${aws_vpc.jobassist_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }

  tags {
    Name = "web_rt"
  }
}

# Associate Public subnets to web_rt

resource "aws_route_table_association" "a" {
  count          = "${length(data.aws_availability_zones.azs.names)}"
  subnet_id      = "${aws_subnet.webservers.*.id[count.index]}"
  route_table_id = "${aws_route_table.web_rt.id}"
}

resource "aws_subnet" "rds" {
  count                   = 2
  vpc_id                  = "${aws_vpc.jobassist_vpc.id}"
  cidr_block              = "${var.db_cidrs[count.index]}"
  availability_zone       = "${data.aws_availability_zones.azs.names[count.index]}"
  map_public_ip_on_launch = false

  tags {
    Name = "PrivateSubnet-${count.index + 1}"
  }
}
