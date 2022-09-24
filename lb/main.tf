resource "aws_lb" "application" {
  count                      = var.lb_type == "application" ? 1 : 0
  name                       = format("%s-%s-alb", var.env, var.namespace)
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = ["sg-0bc38974acc0a9719"]
  subnets                    = ["subnet-0a3160ebcff23d19f", "subnet-0fadfeda7e41e6c31"]
  enable_deletion_protection = true
}

resource "aws_lb" "network" {
  count                      = var.lb_type == "network" ? 1 : 0
  name                       = format("%s-%s-alb", var.env, var.namespace)
  internal                   = false
  load_balancer_type         = "network"
  security_groups            = ["sg-0bc38974acc0a9719"]
  subnets                    = ["subnet-0a3160ebcff23d19f", "subnet-0fadfeda7e41e6c31"]
  enable_deletion_protection = true
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = var.lb_type == "application" ? aws_lb.application[0].arn : aws_lb.network[0].arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Fixed response content"
      status_code  = "200"
    }
  }
}


resource "aws_lb_target_group" "this" {
  name        = format("%s-%s-tg", var.env, var.namespace)
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = "vpc-07c66f6793c5bede9"
}

resource "aws_lb_listener_rule" "this" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }

  condition {
    path_pattern {
      values = ["/payment/*"]
    }
  }
}