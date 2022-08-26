variable "ssh_keys" {
  type        = list(string)
  description = "List of ssh keys"
}

variable "packages" {
  type        = list(string)
  description = "List of packages (softwares) what you want to install on a remote system"
  default     = [""]
}

variable "additional_cloud_init_content" {
  type        = string
  description = "Additional content formatted to be a part of cloud-init"
  default     = ""
}