variable "bucket_name" {
  type        = string
  description = "remote state bucket name"
}

variable "name" {
  type        = string
  description = "tag name"
}

variable "environment" {
  type        = string
  description = "environment name"
}

variable "vpc_cidr" {
  type        = string
  description = "vpc cidr value"
}

variable "vpc_name" {
  type        = string
  description = "vpc name"
}

variable "cidr_public_subnet" {
  type        = list(string)
  description = "public subnet cidr values"
}

variable "cidr_private_subnet" {
  type        = list(string)
  description = "private subnet cidr values"
}

variable "us_availibility_zone" {
  type        = list(string)
  description = "tag name"
}

variable "public_key" {
  type        = string
  description = "public key for ec2"
}


variable "domain_name" {
  type        = string
  description = "domain name"
}

variable "ec2-ami-id" {
  type        = string
  description = "ami from aws ubuntu"
}

variable "ec2_user_data" {
  type        = string
  description = "script bash"
}
