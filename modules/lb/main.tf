resource "aws_lb" "vpc_lb" {
  name = var.lb_name
  internal = var.is_external
  load_balancer_type = var.lb_type
  security_groups = [var.ec2_sg_http]
  subnets = var.subnet_ids
  enable_deletion_protection = false
  tags = {
    name = "example-lb"
  }
}
resource "aws_lb_target_group_attachment" "vpc_lb_tga" {
  target_group_arn = var.lb_tg_arn
  target_id = var.ec2_instance_id
  port = var.lb_tg_ap
}
resource "aws_lb_listener" "vpc_lb_listener" {
  load_balancer_arn = aws_lb.vpc_lb.arn
  port = var.lb_listener
  protocol = var.lb_listener_pro
  default_action {
    type = var.lb_listener_def
    target_group_arn = var.lb_tg_arn
  }
}
resource "aws_lb_listener" "vpc_lb_https_listener" {
  load_balancer_arn = aws_lb.vpc_lb.arn
  port = var.lb_listener
  protocol = var.lb_listener_pro
  ssl_policy = "ELBSecurityPolicy-FS-1-2-Res-2019-08"
  certificate_arn = var.vpc_arn
  default_action {
    type = var.lb_listener_def
    target_group_arn = var.lb_tg_arn
  }
}