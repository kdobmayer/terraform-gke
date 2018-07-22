terraform {
  backend "gcs" {
    bucket = "terraform-kdobmayer"
    prefix = "kubernetes"
  }
}
