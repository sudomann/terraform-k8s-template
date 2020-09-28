variable "credentials" {
}

variable "desired_k8s_version" {
  default = "1.13.6-gke.13"
}

variable "dev_env_name_servers" {
  type = list(string)
}

variable "fqdn" {
}

