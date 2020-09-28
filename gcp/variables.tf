variable "environment" {
  type = map(string)

  default = {
    "production"  = "mygcpproject-prod"
    "development" = "mygcpproject-dev"
  }
}

variable "credentials_production" {
}

variable "credentials_development" {
}

variable "fqdn" {
}

