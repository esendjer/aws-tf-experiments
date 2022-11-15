locals {
  alphabet     = ["b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
  device_names = [for index in range(var.instance_count) : format("/dev/sd%s", local.alphabet[index])]
}
resource "aws_instance" "webapp" {
  for_each = toset(formatlist("${var.instance_name_prefix}-%s", range(var.instance_count)))

  ami                    = var.ami
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.ec2_ssh_web.id]
  key_name               = var.main_key_name // data.terraform_remote_state.kms-ssh.outputs.key_name
  user_data              = module.cloud_init.rendered

  dynamic "ebs_block_device" {
    for_each = local.device_names
    iterator = device
    content {
      device_name = device.value
      volume_size = 8
      volume_type = "gp3"
    }
  }
  tags = {
    "Name" = each.key
  }
}
