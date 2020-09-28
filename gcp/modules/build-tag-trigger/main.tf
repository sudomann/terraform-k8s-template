resource "google_cloudbuild_trigger" "myproduct" {
  description = var.description

  # ignored_files = 
  # included_files = 
  trigger_template {
    repo_name = var.repo_name
    tag_name  = ".*" # any tag
    #branch_name = "develop"
  }

  build {
    images = [
      "${var.image_name_prefix}/${var.image_name}:${var.image_tag}",
    ]
    step {
      name = "gcr.io/cloud-builders/docker"
      dir  = var.build_dir
      args = [
        "build",
        "-t",
        "${var.image_name_prefix}/${var.image_name}:${var.image_tag}",
        ".",
      ]
    }

    step {
      name = "gcr.io/cloud-builders/docker"
      dir  = var.build_dir
      args = [
        "push",
        "${var.image_name_prefix}/${var.image_name}:${var.image_tag}",
      ]
    }
  }
}

