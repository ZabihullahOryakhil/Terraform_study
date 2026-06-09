terraform {
  cloud {
    organization = "Orya-org"
    workspaces {
      name = "terraform-state-demo"
    }
  }
}