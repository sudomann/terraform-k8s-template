module "gcp" {
  source                  = "./gcp"
  credentials_production  = var.gcp_credentials_production
  credentials_development = var.gcp_credentials_development
  fqdn                    = var.fqdn
}

# Can use multiple workspaces:
terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "MyProduct"

    workspaces {
      prefix = "myproduct-"
    }
  }
}

