variable "project" {
  type = "string"
  description = "Google Cloud project name"
}

variable "region" {
  type = "string"
  description = "Default Google Cloud region"
}

terraform {
  backend "gcs" {
    bucket = "dito-chat"
    prefix = "terraform"
    credentials = "account.json"
  }
}

provider "google" {
  credentials = "${file("${path.module}/account.json")}"
  project     = "${var.project}"
  region      = "${var.region}"
}

