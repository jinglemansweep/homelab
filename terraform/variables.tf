variable "cloudflare_account_name" {
  type        = string
  description = "Cloudflare Account Name"
}

variable "infisical_workspace_id" {
  type        = string
  description = "Infisical Workspace ID"
}

variable "infisical_environment" {
  type        = string
  description = "Infisical Environment"
  default     = "prod"
}

variable "cloudflare_zones" {
  type = list(object({
    domain_name = string
    records = list(object({
      name    = string
      type    = string
      value   = string
      proxied = bool
    }))
  }))
  description = "List of zones to create"
  default     = []
}
