variable "vpc_id" {
  type        = string
  description = "AWS VPC id"
}

variable "targets" {
  type = map(object({
    id = string
  }))
  description = "Targets that should be attached to the target group"
}

variable "redirect_to_port" {
  type        = number
  description = "Port for redirection to"
}