user_name            = "webapp-user"
instance_type        = "t2.micro"
vpc_id               = "vpc-01234567"
ami                  = "ami-090fa75af13c156b4" // Amazon Linux 2 Kernel 5.10 AMI 2.0.20220719.0 x86_64 HVM gp2 in us-east-1
instance_name_prefix = "webapp"
instance_count       = 2
key_name             = "your-user-pub-key"
ssh_keys = [
  "ssh-ed25519 XXX your-user-pub-key",
  "ssh-rsa YYY your-user-pub-key"
]
redirect_to_port = 8080