terraform {
  required_version = ">= 1.5.7"

  # rand="$(echo $RANDOM)" && gsutil mb -p <project-name> -l us -b on "gs://tf-state-bootstrap-$rand" && gsutil versioning set on "gs://tf-state-bootstrap-$rand"
  backend "gcs" {
    bucket = "tf-state-bootstrap-16824"
    prefix = "terraform/state/organization"
  }

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.83"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = ">= 4.83"
    }
  }
}
