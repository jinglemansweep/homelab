# SECRETS

# Infisical

provider "infisical" {
  host = "https://app.infisical.com"
  auth = {
    universal-auth = {}
  }
}

data "infisical_secrets" "homelab" {
  env_slug     = var.secrets.infisical.environment
  workspace_id = var.infisical_workspace_id
  folder_path  = "/"
}

# CLOUDFLARE

provider "cloudflare" {
  api_token = data.infisical_secrets.homelab.secrets["CLOUDFLARE_API_TOKEN"].value
}

resource "cloudflare_account" "personal" {
  name = var.cloud.dns.cloudflare.account_name
}

module "cloudflare_zones" {
  source      = "./modules/cloudflare/zone"
  for_each    = { for zone in var.cloud.dns.cloudflare.zones : zone.domain_name => zone }
  account_id  = cloudflare_account.personal.id
  domain_name = each.value.domain_name
  records     = each.value.records
}

# PROXMOX

module "proxmox" {
  source       = "./modules/proxmox/vm"
  name         = "test"
  target_node  = "pvm1"
  vmid         = 881
  api_endpoint = var.proxmox.endpoint
  api_username = data.infisical_secrets.homelab.secrets["PROXMOX_USERNAME"].value
  api_password = data.infisical_secrets.homelab.secrets["PROXMOX_PASSWORD"].value
}
