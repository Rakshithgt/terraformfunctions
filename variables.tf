variable "aws_region" {}
variable "vpc_cidr" {}
variable "vpc_name" {}
variable "key_name" {}
variable "azs" {}
variable "public_cidr_block" {
  type = list(string)
}
variable "private_cidr_block" {
  type = list(string)
}
variable "environment" {}
variable "ingress_value" {
  description = "List of allowed ports for inbound traffic"
  type        = list(number)
}




