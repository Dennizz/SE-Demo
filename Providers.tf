terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.0.0"
    }
    aviatrix = {
      source  = "AviatrixSystems/aviatrix"
      version = "~> 3.1.2"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.56.0"
    }
    google = {
      source  = "hashicorp/google"
      version = "~> 4.66.0"
    }
    oracle = {
      source  = "oracle/oci"
      version = "~> 5.13.0"
    }
  }
}

provider "aviatrix" {
  skip_version_validation = true
  verify_ssl_certificate  = false
  #Load Aviatrix credentials by setting the environmental variables.
}

provider "aws" {
  region = "us-east-1"
  #Load AWS credentials by setting the environmental variables, or authenticating using Azure CLI.
}

resource "azurerm_resource_group" "Azure_Resource_Group" {
  name     = var.Azure_resource_group
  location = var.Azure_region
}

provider "azurerm" {
  features {}
  #Load Azure credentials by setting the environmental variables, or authenticating using Azure CLI.
}

provider "google" {
  project = var.GCP_project
  region  = var.GCP_region
}
