# Create Role
# Create a Policy
# Attach Role with Policy
resource "aws_iam_role" "ec2_role" {
  name               = "7am-iam-role-for-ec2"
  assume_role_policy = "${file("./iam/ec2_assume_role.json")}"
}

resource "aws_iam_policy" "ec2_policy" {
  name        = "7am-iam-policy-for-ec2"
  description = "7am-iam-policy-for-ec2"
  policy      = "${file("./iam/iam-policy-ec2.json")}"
}

resource "aws_iam_role_policy_attachment" "role-policy-attach" {
  role       = "${aws_iam_role.ec2_role.name}"
  policy_arn = "${aws_iam_policy.ec2_policy.arn}"
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "${aws_iam_role.ec2_role.name}"
  role = "${aws_iam_role.ec2_role.name}"
}
