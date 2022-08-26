resource "aws_security_group" "ec2_ssh_web" {
  name        = "EC2 SSH and Web"
  description = "SG for wizlabs_ec2"
  vpc_id      = data.aws_vpc.webapp.id
}

resource "aws_security_group_rule" "ec2_ssh_in" {
  description       = "Allows SSH inbound from the Internet"
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ec2_ssh_web.id
}

resource "aws_security_group_rule" "ec2_http_in" {
  description = "Allows HTTPS inbound inside VPC"
  type        = "ingress"
  from_port   = 8080
  to_port     = 8080
  protocol    = "tcp"
  cidr_blocks = [data.aws_vpc.webapp.cidr_block]
  #   ipv6_cidr_blocks  = [data.aws_vpc.default.ipv6_cidr_block]
  security_group_id = aws_security_group.ec2_ssh_web.id
}

resource "aws_security_group_rule" "ec2_all_out" {
  description       = "Allows all outbound traffic"
  type              = "egress"
  to_port           = 0
  protocol          = "-1"
  from_port         = 0
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ec2_ssh_web.id
}