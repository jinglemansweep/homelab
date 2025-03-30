terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "peachtrees"
    workspaces {
      name = "state"
    }
  }
  required_providers {
    infisical = {
      source  = "infisical/infisical"
      version = "~> 0.3"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.1"
    }
  }
}
