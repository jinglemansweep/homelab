
provider "infisical" {
  host = "https://app.infisical.com"
  auth = {
    universal-auth = {}
  }
}

data "infisical_secrets" "homelab" {
  env_slug     = var.infisical_environment
  workspace_id = var.infisical_workspace_id
  folder_path  = "/"
}

output "fastmail_smtp_host" {
  value     = data.infisical_secrets.homelab.secrets["FASTMAIL_SMTP_HOST"]
  sensitive = true
}
