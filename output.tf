output "WORKLOAD_IDENTITY_POOL_PROVIDER_NAME" {
  value = module.wif.workload_identity_pool_provider_name
}

output "GCP_SERVICE_ACCOUNT" {
  value = google_service_account.gitlab_ci.email
}

output "GCP_SERVICE_ACCOUNT_VIEWER" {
  value = google_service_account.gitlab_ci_viewer.email
}
