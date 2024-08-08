output "connection_for_ec2" {
  value = format("%s%s", "ssh -i /home/ubuntu/keys/aws_ec2_terraform ubuntu@",aws_instance.ec2_instance.public_ip)
}
output "ec2_instance_id" {
  value = aws_instance.ec2_instance.id
}