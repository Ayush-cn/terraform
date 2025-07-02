
resource "aws_launch_template" "this" {
  name_prefix   = "${var.name}-lt"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = 30
      volume_type = "gp2"
    }
  }

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [var.security_group_id]
  }
}

resource "aws_autoscaling_group" "this" {
  desired_capacity     = 2
  max_size             = 3
  min_size             = 1
  vpc_zone_identifier  = var.subnet_ids

  launch_template {
    id      = aws_launch_template.this.id
    version = "$Latest"
  }

  target_group_arns = [aws_lb_target_group.this.arn]
}

resource "aws_lb" "this" {
  name               = "${var.name}-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.security_group_id]
  subnets            = var.subnet_ids
}

resource "aws_lb_target_group" "this" {
  name     = "${var.name}-tg"
  port     = 443
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    protocol = "HTTP"
    path     = "/"
  }
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.this.arn
  port              = 443
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}
