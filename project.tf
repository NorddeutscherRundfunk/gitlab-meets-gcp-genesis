module "showcase" {
  source              = "terraform-google-modules/project-factory/google"
  version             = "14.4.0"
  name                = "showcase"
  org_id              = var.org_id
  folder_id           = var.folder_id
  random_project_id   = true
  billing_account     = var.billing_account
  auto_create_network = false

  create_project_sa = false

  labels = {
    verteilung_ndr  = "100",
    order_number    = var.order_number,
    suborder_number = var.suborder_number,
  }

  activate_apis = [
    "iam.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "cloudbilling.googleapis.com",
    "serviceusage.googleapis.com",
  ]
}
