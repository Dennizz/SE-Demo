variable "company_name" {
  type     = string
  default  = "demo"
  nullable = false

  validation {
    condition     = length(var.company_name) <= 15
    error_message = "Name is too long. Max length is 15 characters."
  }

  validation {
    condition     = can(regex("^[a-zA-Z0-9-_]*$", var.company_name))
    error_message = "Only a-z, A-Z, 0-9 and hyphens and underscores are allowed."
  }
}

variable "high_availability" {
  type     = bool
  default  = true
  nullable = false
}

variable "AWS_account" {
  type    = string
  default = "AWS-Environment"
}

variable "AWS_region" {
  description = "The AWS region to deploy resources into."
  type        = string
  default     = "us-east-1"
}

variable "Azure_account" {
  type    = string
  default = "Azure-Environment"
}

variable "Azure_region" {
  type    = string
  default = "East US"
}

variable "Azure_resource_group" {
  type    = string
  default = "Demo"
}

variable "GCP_account" {
  type    = string
  default = "GCP-Environment"
}

variable "GCP_region" {
  description = "The GCP region to deploy resources into."
  type        = string
  default     = "us-east1"
}

variable "GCP_project" {
  description = "The GCP project to deploy resources into."
  type        = string
}

variable "OCI_account" {
  type    = string
  default = "OCI-Environment"
}

variable "OCI_region" {
  description = "The OCI region to deploy resources into."
  type        = string
  default     = "us-ashburn-1"
}

variable "Prod_Smartgroup" {
  type    = string
  default = "Prod-Workloads"
}

variable "Dev_Smartgroup" {
  type    = string
  default = "Dev-Workloads"
}

variable "QA_Smartgroup" {
  type    = string
  default = "QA-Workloads"
}

variable "App_1" {
  type    = string
  default = "QA-Workloads"
}

variable "Webgroup_1" {
  type    = string
  default = "WG-Github"
}

variable "Webgroup_1_SNI_Filter" {
  type    = string
  default = "*.example.com"
}

variable "domain_connections" {
  default = [
    ["prod", "shared"],
    ["dev", "shared"],
  ]
  description = "A list of domain connection policies"
  nullable    = false
}

variable "additional_domains" {
  default     = []
  description = "A list of additional domains to be created"
  nullable    = false
}

variable "build_aws_transit" {
  description = "Toggle this boolean for building or not building this part of the infrastructure."
  type        = bool
  nullable    = false
  default     = true
}

variable "build_azure_transit" {
  description = "Toggle this boolean for building or not building this part of the infrastructure."
  type        = bool
  nullable    = false
  default     = true
}

variable "build_gcp_transit" {
  description = "Toggle this boolean for building or not building this part of the infrastructure."
  type        = bool
  nullable    = false
  default     = true
}

variable "build_oci_transit" {
  description = "Toggle this boolean for building or not building this part of the infrastructure."
  type        = bool
  nullable    = false
  default     = true
}

variable "build_aws_firenet" {
  description = "Toggle this boolean for building or not building this part of the infrastructure."
  type        = bool
  nullable    = false
  default     = true
}

variable "build_azure_firenet" {
  description = "Toggle this boolean for building or not building this part of the infrastructure."
  type        = bool
  nullable    = false
  default     = true
}

variable "build_gcp_firenet" {
  description = "Toggle this boolean for building or not building this part of the infrastructure."
  type        = bool
  nullable    = false
  default     = true
}

variable "build_oci_firenet" {
  description = "Toggle this boolean for building or not building this part of the infrastructure."
  type        = bool
  nullable    = false
  default     = true
}

variable "build_aws_spokes" {
  description = "Toggle this boolean for building or not building this part of the infrastructure."
  type        = bool
  nullable    = false
  default     = true
}

variable "build_azure_spokes" {
  description = "Toggle this boolean for building or not building this part of the infrastructure."
  type        = bool
  nullable    = false
  default     = true
}

variable "build_gcp_spokes" {
  description = "Toggle this boolean for building or not building this part of the infrastructure."
  type        = bool
  nullable    = false
  default     = true
}

variable "build_oci_spokes" {
  description = "Toggle this boolean for building or not building this part of the infrastructure."
  type        = bool
  nullable    = false
  default     = true
}

variable "firewall_vendor" {
  nullable = false
  default  = "paloalto"
}
