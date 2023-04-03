
locals {
  vault_config = jsonencode({
    "disable_mlock" = "false",
    "listener" = {
      "tcp" = {
        "address"     = "0.0.0.0:${var.vault_port}"
        "tls_disable" = true
      }
    },
    "seal" = {
      "transit" = {
        "address"         = var.encryption_server_address
        "disable_renewal" = false
        "key_name"        = "autounseal_wolf"
        "mount_path"      = "transit/"
        "tls_skip_verify" = false
      }
    },
    "storage" = {
      "file" = {
        "path" = "/vault/file"
      }
    },
    "ui" = "true"
  })
}
