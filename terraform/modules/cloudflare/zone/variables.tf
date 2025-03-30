variable "account_id" {
  description = "Cloudflare Account ID"
  type        = string
}

variable "domain_name" {
  description = "Domain Name"
  type        = string
}

variable "records" {
  description = "DNS Records"
  type = list(object({
    name    = string
    type    = string
    value   = string
    proxied = bool
  }))
  default = []
}
