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
  type = list(any)
  default = []
}

variable "default_ttl" {
  description = "Default TTL for DNS Records"
  type        = number
  default     = 3600
}
