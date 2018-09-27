resource "aws_security_group" "webservers-sg" {
  name        = "webservers-sgl"
  description = "Allow 80 from all and 22 from our network"
  vpc_id      = "${aws_vpc.jobassist_vpc.id}"

  # ingress - Inbound Rule
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["172.17.0.0/16"]
  }

  # Outbound Rule
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
