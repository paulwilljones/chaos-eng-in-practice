variable "gcp_project" {
  description =  "Name of the Google Compute project to use"
  type = "string"
}

variable "gcp_region" {
  description = "Google Compute region to use for the cluster"
  type = "string"
  default = "europe-west2"
}

variable "cluster_name" {
  description = "Google Container Cluster name to use for the cluster"
  type = "string"
}

variable "gcp_zone" {
  description = "Google Computer zone to use for the cluster"
  type = "string"
  default = "europe-west2-a"
}

variable "additional_gcp_zones" {
  description = "Google Computer zones for other nodes"
  type = "list"
  default = ["europe-west2-b", "europe-west2-c"]
}

variable "gcp_cluster_count" {
  description = "Count of cluster instances to start."
  type = "string"
}
