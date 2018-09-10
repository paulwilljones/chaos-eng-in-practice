provider "google" {
  project     = "${var.gcp_project}"
  region      = "${var.gcp_region}"
  credentials = "${file("./account.json")}"
}

resource "google_container_cluster" "primary" {
  name               = "${var.cluster_name}"
  zone               = "${var.gcp_zone}"
  initial_node_count = "${var.gcp_cluster_count}"
  additional_zones   = "${var.additional_gcp_zones}"
}
