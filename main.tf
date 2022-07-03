terraform {
  required_providers {
    vra = {
      source  = "vmware/vra"
      version = "0.5.1"
    }
  }
}

provider "vra" {
  url           = var.vra_url
  refresh_token = var.vra_refresh_token
}

data "vra_deployment" "this" {
  name = var.vra_deploymentName
}

resource "vra_deployment" "this" {
  name        = var.vra_deploymentName
  description = "Deployed from vRA provider for Terraform."

  blueprint_id = var.vra_blueprintId
  project_id   = var.vra_projectId

  inputs = {
    image        = "ubuntu1804"
    flavor       = "medium"
    region       = "region:sydney"
    platform     = "platform:aws"
    applications = "moad"
    workloadtype = "function:public"
  }
}
