output "hosted_zone_id" {
  value = data.aws_route53_zone.vpc_cloudwithsami_free_nf.zone_id
}