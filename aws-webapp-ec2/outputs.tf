output "instances" {
  value = {
    for k, v in tomap(aws_instance.webapp) : k => {
      id         = v.id,
      public_ip  = v.public_ip,
      arn        = v.arn,
      private_ip = v.private_ip
    }
  }
}