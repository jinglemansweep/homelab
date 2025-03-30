
# NEW PROPOSED DESIGN BELOW

variable "env_name" {
  type        = string
  description = "Environment Name"
}

variable "cloud" {
  type = object({
    dns = object({
      cloudflare = object({
        account_name = string
        zones = list(object({
          domain_name = string
          records = list(object({
            name    = string
            type    = string
            value   = string
            proxied = bool
          }))
        }))
      })
    })
  })
  description = "Cloud Configuration"
}

variable "secrets" {
  type = object({
    infisical = object({
      environment  = string
      secrets_path = string
    })
  })
  description = "Secrets Configuration"
}

variable "proxmox" {
  type        = any
  description = "Proxmox Configuration"
}

variable "talos" {
  type = object({
    endpoint = string
    nodes = object({
      controlplanes = any
      workers       = any
    })
    install_image = string
  })
  description = "Talos Configuration"
}

# External (TF_VAR_)

variable "infisical_workspace_id" {
  type = string
}
