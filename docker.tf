resource "docker_volume" "vault_data" {
  name = var.docker_volume_name
}

resource "docker_network" "vault" {
  driver = "bridge"
  name   = var.docker_network_name
}

resource "docker_container" "vault" {
  name  = "vault"
  image = "vault:${var.vault_version}"

  # Add IPC_LOCK 
  capabilities {
    add = ["IPC_LOCK"]
  }

  command = ["/usr/local/bin/docker-entrypoint.sh", "server"]

  env = [
    "VAULT_LOCAL_CONFIG=${local.vault_config}",
    "VAULT_API_ADDR=${var.vault_ip_address}",
    "VAULT_TOKEN=${var.unsealing_token}"
  ]

  networks_advanced {
    name = docker_network.vault.name
  }

  ports {
    internal = var.vault_port
    external = var.vault_port
    ip       = var.host_ip
  }

  restart = "always"

  # Mount the volume to the container
  volumes {
    volume_name    = docker_volume.vault_data.name
    container_path = "/vault"
  }

  depends_on = [
    docker_volume.vault_data,
    docker_network.vault,
  ]
}