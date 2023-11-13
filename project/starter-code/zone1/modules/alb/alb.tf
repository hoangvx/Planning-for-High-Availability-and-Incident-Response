variable "vpc_id" {}
variable "subnets_id" {}
variable "ec2" {}

resource "aws_lb" "udacity" {
  name               = "udacity"
  internal           = false
  load_balancer_type = "application"

  security_groups = [aws_security_group.alb_sg.id]
  subnets         = var.subnets_id

  enable_deletion_protection = false
}

resource "aws_security_group" "alb_sg" {
  name   = "alb_sg"
  vpc_id = var.vpc_id

  ingress {
    description = "web port"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "alb_sg"
  }
}

resource "aws_lb_target_group_attachment" "udacity_tg_attachment" {
  count            = 3
  target_group_arn = aws_lb_target_group.udacity_tg.arn
  target_id        = var.ec2.*.id[count.index]
  port             = 80
}

resource "aws_lb_target_group" "udacity_tg" {
  name     = "udacity-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_listener" "udacity_listener" {
  load_balancer_arn = aws_lb.udacity.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.udacity_tg.arn
  }
}
