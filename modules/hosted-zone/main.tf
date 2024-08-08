data "aws_route53_zone" "vpc_cloudwithsami_free_nf" {
  name = var.domain_name
  private_zone = false
}

resource "aws_route53_record" "lb_record" {
  zone_id = data.aws_route53_zone.vpc_cloudwithsami_free_nf.zone_id
  name = var.domain_name
  type = "A"
  alias {
    name = var.lb_dns_name
    zone_id = var.lb_zone_id
    evaluate_target_health = true
  }
}