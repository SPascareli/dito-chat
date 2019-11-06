variable "project" {}
variable "region" {}
variable "general_purpose_machine_type" {}
variable "general_purpose_min_node_count" {}
variable "general_purpose_max_node_count" {}


module "gke" {
  source   = "./gke"
  project  = "${var.project}"
  region   = "${var.region}"
  general_purpose_machine_type = "${var.general_purpose_machine_type}"
  general_purpose_min_node_count = "${var.general_purpose_min_node_count}"
  general_purpose_max_node_count = "${var.general_purpose_max_node_count}"
}

module "k8s" {
  source   = "./k8s"
  host     = "${module.gke.host}"

  project = "${var.project}"

  client_certificate     = "${module.gke.client_certificate}"
  client_key             = "${module.gke.client_key}"
  cluster_ca_certificate = "${module.gke.cluster_ca_certificate}"
}
