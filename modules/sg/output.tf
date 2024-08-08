output "ec2_sg_http" {
  value = aws_security_group.ec2_sg_http.id
}
output "rds_mysql_sg" {
  value = aws_security_group.rds_mysql_sg.id
}
output "ec2_sg_for_flask_api" {
  value = aws_security_group.flask_api_sg.id
}