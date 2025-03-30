# ======================================================================================================================
# INFISICAL
# ======================================================================================================================

# Infisical

provider "infisical" {
  host = var.infisical_host
}

# ======================================================================================================================
# CLOUDFLARE
# ======================================================================================================================

ephemeral "infisical_secret" "cloudflare_api_token" {
  name         = "api_token"
  env_slug     = var.infisical_environment
  workspace_id = var.infisical_workspace_id
  folder_path  = "/cloudflare"
}

provider "cloudflare" {
  api_token = ephemeral.infisical_secret.cloudflare_api_token.value
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

# ======================================================================================================================
# PROXMOX
# ======================================================================================================================

# Secrets

ephemeral "infisical_secret" "proxmox_pvm1_username" {
  name         = "username"
  env_slug     = var.infisical_environment
  workspace_id = var.infisical_workspace_id
  folder_path  = "/proxmox/pvm1"
}

ephemeral "infisical_secret" "proxmox_pvm1_password" {
  name         = "password"
  env_slug     = var.infisical_environment
  workspace_id = var.infisical_workspace_id
  folder_path  = "/proxmox/pvm1"
}

ephemeral "infisical_secret" "proxmox_pvm2_username" {
  name         = "username"
  env_slug     = var.infisical_environment
  workspace_id = var.infisical_workspace_id
  folder_path  = "/proxmox/pvm2"
}

ephemeral "infisical_secret" "proxmox_pvm2_password" {
  name         = "password"
  env_slug     = var.infisical_environment
  workspace_id = var.infisical_workspace_id
  folder_path  = "/proxmox/pvm2"
}

# Providers

provider "proxmox" {
  alias           = "pvm1"
  pm_api_url      = var.proxmox.pvm1.endpoint
  pm_user         = ephemeral.infisical_secret.proxmox_pvm1_username.value
  pm_password     = ephemeral.infisical_secret.proxmox_pvm1_password.value
  pm_tls_insecure = true
}

provider "proxmox" {
  alias           = "pvm2"
  pm_api_url      = var.proxmox.pvm2.endpoint
  pm_user         = ephemeral.infisical_secret.proxmox_pvm2_username.value
  pm_password     = ephemeral.infisical_secret.proxmox_pvm2_password.value
  pm_tls_insecure = true
}

# Instances

module "vm_pvm1_test" {
  source = "./modules/proxmox/vm"
  providers = {
    proxmox = proxmox.pvm1
  }
  name            = "test"
  target_node     = "pvm1"
  vmid            = 881
  iso             = "nas:iso/ubuntu-24.04-live-server-amd64.iso"
  net_mac_address = "01:00:00:00:00:00"
}

#module "vm_pvm2_test" {
#  source = "./modules/proxmox/vm"
#  providers = {
#    proxmox = proxmox.pvm2
#  }
#  name            = "test"
#  target_node     = "pvm2"
#  vmid            = 882
#  iso             = "nas:iso/ubuntu-24.04-live-server-amd64.iso"
#  net_mac_address = "02:00:00:00:00:00"
#}
