resource "google_kms_crypto_key_iam_member" "apigee_sa_key_user" {
  
  crypto_key_id = google_kms_crypto_key.apigee_runtimedb_kms_key.id
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  member        = "serviceAccount:service-${data.google_project.target_project.number}@gcp-sa-apigee.iam.gserviceaccount.com"
}
