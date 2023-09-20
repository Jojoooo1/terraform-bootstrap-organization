/******************************************
  Dev folders
 *****************************************/
resource "google_folder" "dev" {
  display_name = "development"
  parent       = local.organization_folder_id
}
resource "google_folder" "dev_shared" {
  display_name = "shared"
  parent       = google_folder.dev.name
}
resource "google_folder" "dev_services" {
  display_name = "services"
  parent       = google_folder.dev.name
}

/******************************************
  Production folders
 *****************************************/
resource "google_folder" "production" {
  display_name = "production"
  parent       = local.organization_folder_id
}
resource "google_folder" "production_shared" {
  display_name = "shared"
  parent       = google_folder.production.name
}
resource "google_folder" "production_services" {
  display_name = "services"
  parent       = google_folder.production.name
}

/******************************************
  Public folders (public assets like CDN, public bucket etc.)
 *****************************************/
resource "google_folder" "public" {
  display_name = "public"
  parent       = local.organization_folder_id
}
