terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "peachtrees"
    workspaces {
      name = "state"
    }
  }
}