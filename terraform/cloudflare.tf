provider "cloudflare" {
  api_token = data.infisical_secrets.homelab.secrets["CLOUDFLARE_API_TOKEN"].value
}

resource "cloudflare_account" "personal" {
  name = var.cloudflare_account_name
}

module "cloudflare_zones" {
  source      = "./modules/cloudflare/zone"
  for_each    = { for zone in var.cloudflare_zones : zone.domain_name => zone }
  account_id  = cloudflare_account.personal.id
  domain_name = each.value.domain_name
  records     = each.value.records
}
