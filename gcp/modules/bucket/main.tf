resource "google_storage_bucket" "file_storage" {
  name     = var.is_prod ? "usercontent.myproduct.com" : "usercontent.dev.myproduct.com"
  location = "US"

  cors {
    origin          = ["*"]
    method          = ["GET", "HEAD", "PUT", "POST", "DELETE"]
    response_header = ["*"]
  }
}

