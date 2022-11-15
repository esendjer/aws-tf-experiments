module "ssh_key" {
  source = "../kms-ssh"

  key_name   = var.key_name
  public_key = var.ssh_keys[0]
}

module "aws_webapp_ec2" {
  source               = "../aws-webapp-ec2"
  additional_ssh_keys  = var.ssh_keys
  ami                  = var.ami
  instance_count       = var.instance_count
  instance_name_prefix = var.instance_name_prefix
  instance_type        = var.instance_type
  main_key_name        = module.ssh_key.key_name // to reflect dependency, but var.key_name also is good
  user_name            = var.user_name
  vpc_id               = var.vpc_id
}

module "aws_webapp_alb" {
  source           = "../aws-webapp-alb"
  vpc_id           = var.vpc_id
  targets          = module.aws_webapp_ec2.instances
  redirect_to_port = var.redirect_to_port
}