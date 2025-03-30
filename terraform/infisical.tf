
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

