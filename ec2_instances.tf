# Add Instances into Public subnet
# Install Apache and deploy web application
# Add 2 instances

resource "aws_instance" "web" {
  count = 2

  # ami           = "${var.web_ami["${var.region}"]}"
  ami           = "${lookup(var.web_ami,var.region)}"
  instance_type = "${var.instance_type}"
  subnet_id     = "${aws_subnet.webservers.*.id[count.index]}"
  user_data     = "${file("./scripts/apache.sh")}"

  tags {
    Name = "Webserver-${count.index + 1}"
  }
}
