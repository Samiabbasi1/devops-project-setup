resource "aws_instance" "ec2_instance" {
  ami = var.ami_id
  instance_type = var.instance_type
  tags = {
    name = var.tag_name
  }
  subnet_id = var.subnet_id
  vpc_security_group_ids = [var.ec2_sg_http,var.ec2_sg_for_flask_api]
  associate_public_ip_address = var.enable_public_ip
  user_data = var.ec2_user_data
  metadata_options {
    http_endpoint = "enabled"
    http_tokens = "required"
  }
}

resource "aws_key_pair" "public_key" {
  key_name = "aws_pub"
  public_key = var.public_key
}