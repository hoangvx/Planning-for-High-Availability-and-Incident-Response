resource "aws_lb" "udacity" {
  name               = "udacity-lb-ue2"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.udacity.id]
  subnets            = [for subnet in var.public_subnet_ids : subnet.id]

  enable_deletion_protection = true

  tags = {
    name = "udacity-lb-ue2"
  }
}

resource "aws_security_group" "udacity" {
  name        = "udacity-alb-sg"
  vpc_id      = var.vpc_id

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

resource "aws_lb_target_group" "udacity" {
  name     = "udacity-alb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_target_group_attachment" "udacity" {
  count            = 2
  target_group_arn = aws_lb_target_group.udacity.arn
  target_id        = var.ec2.*.id[count.index]
  port             = 80
}

resource "aws_lb_listener" "udacity" {
  load_balancer_arn = aws_lb.udacity.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.udacity.arn
  }
}