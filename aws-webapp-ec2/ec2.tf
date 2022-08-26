resource "aws_instance" "webapp" {
  for_each = toset(formatlist("${var.instance_name}-%s", range(var.instance_count)))

  ami                    = var.ami
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.ec2_ssh_web.id]
  key_name               = var.main_key_name  // data.terraform_remote_state.kms-ssh.outputs.key_name
  user_data              = module.cloud_init.rendered
  tags = {
    "Name" = each.key
  }
}
