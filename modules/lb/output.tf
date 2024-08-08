output "lb_dns" {
  value = aws_lb.vpc_lb.dns_name
}
output "lb_zone_id" {
  value = aws_lb.vpc_lb.zone_id
}