# Add Instances into Public subnet
# Install Apache and deploy web application
# Add 2 instances

resource "aws_instance" "web" {
  count = "${length(data.aws_availability_zones.azs.names)}"

  # ami           = "${var.web_ami["${var.region}"]}"
  ami                    = "${lookup(var.web_ami,var.region)}"
  instance_type          = "${var.instance_type}"
  subnet_id              = "${aws_subnet.webservers.*.id[count.index]}"
  user_data              = "${file("./scripts/apache.sh")}"
  iam_instance_profile   = "${aws_iam_instance_profile.ec2_profile.name}"
  vpc_security_group_ids = ["${aws_security_group.webservers-sg.id}"]

  tags {
    Name = "Webserver-${count.index + 1}"
  }
}
