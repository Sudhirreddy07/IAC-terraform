resource "aws_lb_target_group" "test" {
  name     = var.lb-name
  port     = var.port
  protocol = var.protocal
  vpc_id   = var.vpc_id
}

resource "aws_lb" "test" {
  name               = var.lb-name
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.security-ids
  subnets            = var.public-subnets

  tags = {
    Environment = "production"
  }
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.test.arn
  port              = 80
  protocol          = var.protocal

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.test.arn
  }
}

resource "aws_lb_target_group_attachment" "test" {
  target_group_arn = aws_lb_target_group.test.arn
  target_id        = var.targetec2
}
