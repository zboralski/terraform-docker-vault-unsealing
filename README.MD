# Terraform Docker Vault with Transit Auto-Unsealing

This Terraform configuration deploys a HashiCorp Vault on Docker with Transit Auto-Unsealing. It creates a Docker volume, network, and container for running the Vault instance. Based on [Auto-unseal using Transit Secrets Engine](https://developer.hashicorp.com/vault/tutorials/auto-unseal/autounseal-transit).

## Prerequisites

- Terraform v1.x
- Docker installed on the host machine

## Usage

Get an unsealing token

```bash
VAULT_TOKEN=$(vault token create -orphan -policy="autounseal" -wrap-ttl=120 -period=24h -format=json \
  | jq -r .wrap_info.token) vault unwrap -format=json | jq -r .auth.client_token
```

echo $VAULT_TOKEN >terraform.tfvars

```hcl
module "vault" {
  source = "github.com/zboralski/terraform-docker-vault-unsealing"

  encryption_server_address = "https://vault.example.com"
  unseal_token              = var.unseal_token
}

variable "unseal_token" {
  description = "Token used to unseal the vault"
  type        = string
  sensitive = true
}
```

Initialize Vault

```bash
VAULT_ADDR=http://localhost:8200 vault operator init
```

## Inputs

| Name                      | Description                          | Type   | Default         | Required |
|---------------------------|--------------------------------------|--------|-----------------|----------|
| unseal_token              | The unseal token for the Vault.      | string | -               | yes      |
| encryption_server_address | The encryption Vault server address. | string | -               | yes      |
| vault_version             | The Vault version to use.            | string | "latest"        | no       |
| key_name                  | The key name for Transit Auto-Unseal.| string | "autounseal"    | no       |
| host_ip                   | The host IP address.                 | string | "127.0.0.1"     | no       |
| vault_ip_address          | The Vault IP address.                | string | "http://localhost:8200" | no |
| vault_port                | The Vault port.                      | number | 8200            | no       |
| docker_volume_name        | The Docker volume name.              | string | "vault_data"    | no       |
| docker_network_name       | The Docker network name.             | string | "vault"         | no       |
