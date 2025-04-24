
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
          records = list(any)
        }))
      })
    })
  })
  description = "Cloud Configuration"
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

# Infisical

variable "infisical_workspace_id" {
  type = string
}

variable "infisical_environment" {
  type    = string
  default = "dev"
}

variable "infisical_host" {
  type    = string
  default = "https://app.infisical.com"
}
