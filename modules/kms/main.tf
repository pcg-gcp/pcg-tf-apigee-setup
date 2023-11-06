resource "google_kms_key_ring" "apigee_runtimedb_kms_key_ring" {
  name     = "apigee-runtimedb-keyring"
  location = var.gcp_target_region
}

resource "google_kms_crypto_key" "apigee_runtimedb_kms_key" {
  name            = "apigee-runtimedb-key"
  key_ring        = google_kms_key_ring.apigee_runtimedb_kms_key_ring.id
  rotation_period = "90d"
  purpose         = "ENCRYPT_DECRYPT"

  lifecycle {
    prevent_destroy = true
  }
}
