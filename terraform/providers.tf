terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "peachtrees"
    workspaces {
      name = "state"
    }
  }
  required_providers {
    infisical = {
      source  = "infisical/infisical"
      version = "~> 0.3"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "4.52.0"
    }
    proxmox = {
      source  = "Telmate/proxmox"
      version = "3.0.1-rc6"
    }
  }
}
