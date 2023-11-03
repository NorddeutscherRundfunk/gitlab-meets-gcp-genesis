resource "google_service_account" "gitlab_ci" {
  project    = module.showcase.project_id
  account_id = "gitlab-ci"
}

resource "google_project_iam_member" "gitlab_ci" {
  project = module.showcase.project_id
  member  = "serviceAccount:${google_service_account.gitlab_ci.email}"
  role    = each.key

  for_each = toset([
    "roles/owner"
  ])
}

resource "google_service_account" "gitlab_ci_viewer" {
  project    = module.showcase.project_id
  account_id = "gitlab-ci-viewer"
}

resource "google_project_iam_member" "gitlab_ci_viewer" {
  project = module.showcase.project_id
  member  = "serviceAccount:${google_service_account.gitlab_ci_viewer.email}"
  role    = each.key

  for_each = toset([
    "roles/viewer"
  ])
}

module "wif" {
  source            = "gitlab.com/gitlab-com/gcp-oidc/google" # https://gitlab.com/gitlab-com/gl-security/security-operations/infrastructure-security-public/oidc-modules/-/tree/main/terraform-modules/gcp-oidc?ref_type=heads
  version           = "3.1.1"
  google_project_id = module.showcase.project_id
  gitlab_project_id = var.gitlab_project_id
  allowed_audiences = ["https://gitlab.com"]
  oidc_service_account = {
    "owner" = {
      sa_email  = google_service_account.gitlab_ci.email
      attribute = "attribute.ref/main"
    }
    "viewer" = {
      sa_email  = google_service_account.gitlab_ci_viewer.email
      attribute = "attribute.project_id/${var.gitlab_project_id}"
    }
  }
}
