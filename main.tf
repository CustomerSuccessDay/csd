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

resource "random_integer" "suffix" {
  min = 1
  max = 50000
}

resource "vra_deployment" "this" {
  name        = format("%s-%d", var.vra_deploymentName, random_integer.suffix.result)
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
