output "vpc_id" {
  value = aws_vpc.vpc_id.id
}
output "public_subnets_ids" {
  value = aws_subnet.public_subnets_ids.*.id
}
output "public_subnets_cidr" {
  value = aws_subnet.public_subnets_ids.*.cidr_block
}