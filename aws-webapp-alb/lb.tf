resource "aws_lb" "webapp" {
  name               = "webapp-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_web.id]
  subnets            = toset(data.aws_subnet_ids.webapp.ids)
}


resource "aws_lb_listener" "redirect_from_80" {
  load_balancer_arn = aws_lb.webapp.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = var.redirect_to_port
      protocol    = "HTTP"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "webapp_front" {
  load_balancer_arn = aws_lb.webapp.arn
  port              = var.redirect_to_port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.webapp.arn
  }
}

resource "aws_lb_target_group" "webapp" {
  name     = "webapp-lb-tg"
  port     = var.redirect_to_port
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_target_group_attachment" "webapp" {
  for_each         = var.targets
  target_group_arn = aws_lb_target_group.webapp.arn
  target_id        = each.value.id
  port             = var.redirect_to_port
}
