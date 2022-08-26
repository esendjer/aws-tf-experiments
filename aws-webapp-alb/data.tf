data "aws_vpc" "webapp" {
  id = var.vpc_id
}

data "aws_subnet_ids" "webapp" {
  vpc_id = var.vpc_id
}