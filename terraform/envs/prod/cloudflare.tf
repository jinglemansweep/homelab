provider "cloudflare" {
  api_token = data.infisical_secrets.homelab.secrets["CLOUDFLARE_API_TOKEN"].value
}

resource "cloudflare_account" "personal" {
  name = "Personal Account"
}

module "zone_es_ptre" {
  source      = "../../modules/cloudflare/zone"
  account_id  = cloudflare_account.personal.id
  domain_name = "ptre.es"
  records     = []
}

module "zone_net_ptre" {
  source      = "../../modules/cloudflare/zone"
  account_id  = cloudflare_account.personal.id
  domain_name = "ptre.net"
}

module "zone_uk_ptre" {
  source      = "../../modules/cloudflare/zone"
  account_id  = cloudflare_account.personal.id
  domain_name = "ptre.uk"
}
