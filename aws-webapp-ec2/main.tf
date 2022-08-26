module "cloud_init" {
  source   = "../cloud-init"
  ssh_keys = var.additional_ssh_keys
  packages = [
    "golang",
    "curl",
    "wget",
    "git",
    "vim",
    "ca-certificates",
  ]
  additional_cloud_init_content = templatefile(
    "${path.module}/cloud-init.yml",
    {
      user_name = var.user_name
    }
  )
}