
resource "cloudflare_zone" "zone" {
  zone       = var.domain_name
  account_id = var.account_id
}

resource "cloudflare_record" "records" {
  for_each = { for record in var.records : sha256("${record.name}-${record.type}-${record.content}") => record }
  zone_id  = cloudflare_zone.zone.id
  name     = each.value.name
  type     = each.value.type
  content  = each.value.type == "TXT" ? "\"${each.value.content}\"" : each.value.content
  priority = lookup(each.value, "priority", null)
  ttl      = lookup(each.value, "proxied", false) ? 1 : lookup(each.value, "ttl", var.default_ttl)
  proxied  = lookup(each.value, "proxied", false)
}
