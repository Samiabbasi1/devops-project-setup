resource "aws_security_group" "ec2_sg_http" {
  name = var.ec2_sg_name
  description = "enable port 22 and 80"
  vpc_id = var.vpc_id
  ingress {
    description = "allow remote access from everywhere"
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 22
    to_port = 22
    protocol = "tcp"
  }
  ingress {
    description = "allow http request from anywhere"
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 80
    to_port = 80
    protocol = "tcp"
  }
  ingress {
    description = "allow http request from anywhere"
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 443
    to_port = 443
    protocol = "tcp"
  }
  egress {
    description = "allow all outgoing"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    name = "security group to allow 22,80 and 443"
  }
}

resource "aws_security_group" "rds_mysql_sg" {
  name = "rds-sg"
  description = "acces for rds from ec2 in pbs"
  vpc_id = var.vpc_id
  ingress {
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    cidr_blocks = var.public_subnets_cidr
  }
}

resource "aws_security_group" "flask_api_sg" {
  name = "sg for flask api"
  description = "allow http request on 5000"
  vpc_id = var.vpc_id
  ingress {
    description = "on port 5000"
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 5000
    to_port = 5000
    protocol = "tcp"
  }
  tags = {
    name = "sg for python"
  }
}
