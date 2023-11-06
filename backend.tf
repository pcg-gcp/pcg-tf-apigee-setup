terraform {
  backend "gcs" {
    bucket = "tf-sandbox-states-marius"
    prefix = "apigee-setup"
  }
}