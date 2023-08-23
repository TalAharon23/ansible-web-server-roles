provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "web-server-vpc"
  cidr = "10.0.0.0/16"
}

resource "aws_subnet" "web_app_subnet" {
  vpc_id     = module.vpc.vpc_id
  cidr_block = "10.0.1.0/24"
}

resource "aws_internet_gateway" "web_app_igw" {
  vpc_id     = module.vpc.vpc_id
}

resource "aws_route_table" "web_app_route_table" {
  vpc_id     = module.vpc.vpc_id
}

resource "aws_route" "route_to_igw" {
  route_table_id         = aws_route_table.web_app_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.web_app_igw.id
}

resource "aws_route_table_association" "subnet_association" {
  subnet_id      = aws_subnet.web_app_subnet.id
  route_table_id = aws_route_table.web_app_route_table.id
}