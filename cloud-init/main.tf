data "cloudinit_config" "init" {
  gzip          = true
  base64_encode = true

  part {
    content_type = "text/cloud-config"
    content = templatefile(
      "${path.module}/init.tftpl",
      {
        ssh_keys                      = var.ssh_keys
        packages                      = local.packages
        additional_cloud_init_content = var.additional_cloud_init_content
      }
    )
    filename = "cloud-init.txt"
  }
}

locals {
  packages = flatten([
    compact(var.packages),
    [
      "jq",
      "python3",
    ]
  ])
}