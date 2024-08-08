module "networking" {
  source               = "../modules/networking"
  vpc_name             = var.vpc_name
  vpc_cidr             = var.vpc_cidr
  cidr_public_subnet   = var.cidr_public_subnet
  cidr_private_subnet  = var.cidr_private_subnet
  us_availibility_zone = var.us_availibility_zone
}
module "sg" {
  source               = "../modules/sg"
  vpc_id               = module.networking.vpc_id
  ec2_sg_name          = "sg for accessing on port 22,80,443,5000,3306"
  public_subnets_cidr  = tolist(module.networking.public_subnets_cidr)
  ec2_sg_for_flask_api = "allow acces on 5000"
}

module "ec2" {
  source               = "../modules/ec2"
  ami_id               = var.ec2-ami-id
  instance_type        = "t2.micro"
  tag_name             = "Ubuntu Linux EC2"
  public_key           = var.public_key
  subnet_id            = tolist(module.networking.public_subnets_ids)[0]
  ec2_sg_http          = module.sg.ec2_sg_http
  ec2_sg_for_flask_api = module.sg.ec2_sg_for_flask_api
  enable_public_ip     = true
  ec2_user_data        = templatefile("../modules/template/script.sh", {})
}

module "lb_tg" {
  source                   = "../modules/lb-tg"
  lb_target_group_name     = "vpclbtargetgroup"
  lb_target_group_port     = 5000
  lb_target_group_protocol = "HTTP"
  vpc_id                   = module.networking.vpc_id
  ec2_instance_id          = module.ec2.ec2_instance_id

}

module "alb" {
  source             = "../modules/lb"
  lb_name            = "vpclb"
  is_external        = false
  lb_type            = "application"
  ec2_sg_http        = module.sg.ec2_sg_http
  subnet_ids         = tolist(module.networking.public_subnets_ids)
  tag_name           = "vpc_alb"
  lb_tg_arn          = module.lb_tg.vpc_target_group_arn
  lb_listener        = 5000
  ec2_instance_id    = module.ec2.ec2_instance_id
  lb_listener_pro    = "HTTP"
  lb_listener_def    = "forward"
  to_https_list_port = 443
  to_https_list_pro  = "HTTPS"
  vpc_arn            = module.cfm.vpc_acm_arn
  lb_tg_ap           = 5000
}

module "hosted_zone" {
  source      = "../modules/hosted-zone"
  domain_name = var.domain_name
  lb_dns_name = module.alb.lb_dns
  lb_zone_id  = module.alb.lb_zone_id
}

module "cfm" {
  source         = "../modules/cfm"
  domain_name    = var.domain_name
  hosted_zone_id = module.hosted_zone.hosted_zone_id
}

module "rds_db" {
  source               = "../modules/rds"
  db_subnet_group_name = "vpc_subnet_grp"
  subnet_groups        = tolist(module.networking.public_subnets_ids)
  rds_mysql_sg_id      = module.sg.rds_mysql_sg
  mysql_db_identifier  = "mydb"
  mysql_dbname         = "vpc"
  mysql_username       = "dbuser"
  mysql_password       = "dbpass"
}