variable "encryption_server_address" {
  description = "value of the encryption vault server address"
  type        = string
  sensitive   = true
}

variable "vault_version" {
  description = "value of the vault version"
  type        = string
  default     = "latest"
}

variable "unsealing_token" {
  description = "value of the unsealing token"
  type        = string
  sensitive   = true
}

variable "key_name" {
    description = "value of the key name"
    type        = string
    default     = "autounseal"
}

variable "host_ip" {
  description = "value of the host ip"
  type        = string
  default     = "127.0.0.1"
}

variable "vault_ip_address" {
  description = "value of the vault ip address"
  type        = string
  default     = "http://localhost:8200"
  sensitive   = true
}

variable "vault_port" {
  description = "value of the vault port"
  type        = number
  default     = 8200
}

variable "docker_volume_name" {
  description = "value of the docker volume name"
  type        = string
  default     = "vault_data"
}

variable "docker_network_name" {
  description = "value of the docker network name"
  type        = string
  default     = "vault"
}
