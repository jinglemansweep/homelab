
resource "cloudflare_zone" "zone" {
  zone       = var.domain_name
  account_id = var.account_id
}

resource "cloudflare_record" "records" {
  for_each = { for record in var.records : sha256("${record.name}-${record.type}-${record.value}") => record }
  zone_id  = cloudflare_zone.zone.id
  name     = each.value.name
  type     = each.value.type
  value    = each.value.value
  proxied  = each.value.proxied
}
