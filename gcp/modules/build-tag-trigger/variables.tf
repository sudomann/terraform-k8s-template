variable "build_dir" {
}

variable "description" {
}

variable "repo_name" {
  description = <<EOF
    Name of the Google Cloud Source repository to fetch code
    from. That repo mirrors git provider (Github/Gitlab)
  
EOF

}

variable "image_name_prefix" {
  default = "gcr.io/$PROJECT_ID"
}

variable "image_tag" {
  default = "$TAG_NAME"
}

variable "image_name" {
}

