output "WORKLOAD_IDENTITY_POOL_PROVIDER_NAME" {
  value = module.wif.workload_identity_pool_provider_name
}

output "GCP_SA" {
  value = google_service_account.gitlab_ci.email
}
