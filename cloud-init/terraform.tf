terraform {
  required_providers {
    cloudinit = {
      source  = "hashicorp/cloudinit"
      version = "~>2.2.0"
    }
  }
  required_version = ">=1.2.7"
}