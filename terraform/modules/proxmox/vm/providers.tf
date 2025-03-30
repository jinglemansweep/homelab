terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "3.0.1-rc6"
    }
  }
}

provider "proxmox" {
  pm_api_url      = var.api_endpoint
  pm_user         = var.api_username
  pm_password     = var.api_password
  pm_tls_insecure = var.api_tls_insecure
}
