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

variable "AWS_Account" {
  type    = string
  default = "AWS-Environment"
}

variable "AWS_Region" {
  description = "The AWS region to deploy resources into."
  type        = string
  default     = "us-east-1"
}

variable "Azure_Account" {
  type    = string
  default = "Azure-Environment"
}

variable "Azure_Region" {
  type    = string
  default = "East US"
}

variable "Azure_Resource_Group" {
  type = string
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

variable "subnet_index" {
  description = "The CIDR block for the VPC."
  type        = string
  default     = "0"
}

variable "domain_connections" {
  default     = []
  description = "A list of domain connection policies"
  nullable    = false
}

variable "additional_domains" {
  default     = []
  description = "A list of additional domains to be created"
  nullable    = false
}
