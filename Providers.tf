terraform {
  required_providers {
    aviatrix = {
      source  = "AviatrixSystems/aviatrix"
      version = "~> 3.1.2"
    }
  }
}

provider "aviatrix" {
  #skip_version_validation = true # This shouldn't be neccessary. Right version use should be encouraged.
  #verify_ssl_certificate = false # Defaults to false anyway.
  #Load Aviatrix credentials by setting the environmental variables. More info here: https://registry.terraform.io/providers/AviatrixSystems/aviatrix/latest/docs#environment-variables
}
