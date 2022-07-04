terraform {
  required_providers {
    vra = {
      source  = "vmware/vra"
      version = "0.5.1"
    }
  }
  cloud {
    organization = "CustomerSuccess"
    workspaces {
      name = "csd"
    }
  }
}

provider "vra" {
  url           = var.vra_url
  refresh_token = var.vra_refresh_token
}

resource "random_integer" "suffix" {
  min = 1
  max = 50000
}

data "vra_catalog_item" "this" {
  name            = var.catalog_item_name
  expand_versions = true
}

data "vra_project" "this" {
  name = var.project_name
}

resource "vra_deployment" "this" {

  name        = format("%s-%d", var.vra_deploymentName, random_integer.suffix.result)
  description = "Deployed from vRA provider for Terraform."

  catalog_item_id      = data.vra_catalog_item.this.id
  catalog_item_version = var.catalog_item_version
  project_id           = data.vra_project.this.id

  inputs = {
    image        = var.image
    flavor       = var.flavor
    region       = var.region
    platform     = var.platform
    applications = var.applications
    workloadtype = var.workloadtype
  }


}
