module "env_development" {
  source      = "./env-development"
  credentials = var.credentials_development
  fqdn        = var.fqdn
}

module "env_production" {
  source               = "./env-production"
  credentials          = var.credentials_production
  dev_env_name_servers = module.env_development.name_servers
  fqdn                 = var.fqdn
}

