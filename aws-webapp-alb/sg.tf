resource "aws_security_group" "lb_web" {
  name        = "LB Web"
  description = "SG for webapp_lb"
  vpc_id      = data.aws_vpc.webapp.id
}

resource "aws_security_group_rule" "http_extra_in" {
  description       = "Allows inbound HTTP"
  type              = "ingress"
  from_port         = var.redirect_to_port
  to_port           = var.redirect_to_port
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.lb_web.id
}

resource "aws_security_group_rule" "http_80_in" {
  description       = "Allows inbound HTTP"
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.lb_web.id
}

resource "aws_security_group_rule" "all_out" {
  description       = "Allows all outbound traffic"
  type              = "egress"
  to_port           = 0
  protocol          = "-1"
  from_port         = 0
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.lb_web.id
}