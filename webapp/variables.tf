variable "user_name" {
  type        = string
  description = "User name to create on a remote system"
}

variable "instance_type" {
  type        = string
  description = "AWS EC2 Instance type"
}

variable "vpc_id" {
  type        = string
  description = "AWS VPC id"
}

variable "key_name" {
  type        = string
  description = "KMS key name"
}

variable "ami" {
  type        = string
  description = "AMI id"
}

variable "instance_name" {
  type        = string
  description = "Name of EC2 instane"
}

variable "instance_count" {
  type        = number
  description = "Count of EC2 Instances"
}

variable "ssh_keys" {
  type        = list(string)
  description = "List of public parts of SSH keys"
}

variable "redirect_to_port" {
  type        = number
  description = "Port for redirection to"
}