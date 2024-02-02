locals {
  #Gateway names, derived from var.company_name
  transits = {
    AWS = {
      transit_cloud       = "aws"
      transit_name        = format("AWS-%s-Transit", var.company_name)
      transit_cidr        = "10.190.0.0/23"
      transit_asn         = 65001
      transit_ha_gw       = var.high_availability
      transit_region_name = var.AWS_region
      build_transit       = var.build_aws_transit
      firenet             = var.build_aws_firenet
    }
    Azure = {
      transit_cloud       = "azure"
      transit_name        = format("Azure-%s-Transit", var.company_name)
      transit_cidr        = "10.70.0.0/23"
      transit_asn         = 65002
      transit_ha_gw       = var.high_availability
      transit_region_name = var.Azure_region
      build_transit       = var.build_azure_transit
      firenet             = var.build_azure_firenet
    }
    GCP = {
      transit_cloud       = "gcp"
      transit_name        = format("gcp-%s-transit", lower(var.company_name))
      transit_cidr        = "10.120.0.0/23"
      transit_asn         = 65003
      transit_ha_gw       = var.high_availability
      transit_region_name = var.GCP_region
      build_transit       = var.build_gcp_transit
      firenet             = var.build_gcp_firenet
      transit_lan_cidr    = var.build_gcp_firenet ? "10.120.2.0/24" : null
      firenet_egress_cidr = var.build_gcp_firenet ? "10.120.3.0/24" : null
      firenet_mgmt_cidr   = var.build_gcp_firenet && local.firewall_vendor == "paloalto" ? "10.120.4.0/24" : null
    }
    OCI = {
      transit_cloud       = "oci"
      transit_name        = format("OCI-%s-VCN-Transit", var.company_name)
      transit_cidr        = "10.25.0.0/23"
      transit_asn         = 65004
      transit_ha_gw       = var.high_availability
      transit_region_name = var.OCI_region
      build_transit       = var.build_oci_transit
      firenet             = var.build_oci_firenet
    }
  }


  spokes = {
    AWS_Spoke_1 = {
      name   = format("AWS-%s-Spoke-1", var.company_name)
      cloud  = "AWS"
      cidr   = "10.181.0.0/24"
      region = var.AWS_region
      #Additional fields that are supported on spokes (can be added to any of them):
      insane_mode    = false
      network_domain = "Prod"
    }
    AWS_Spoke_2 = {
      name           = format("AWS-%s-Spoke-2", var.company_name)
      cloud          = "AWS"
      cidr           = "10.182.0.0/24"
      region         = var.AWS_region
      network_domain = "Prod"
    }
    Azure_Spoke_1 = {
      name           = format("Azure-%s-Spoke-1", var.company_name)
      cloud          = "Azure"
      cidr           = "10.81.0.0/24"
      region         = var.Azure_region
      network_domain = "Dev"
    }
    Azure_Spoke_2 = {
      name           = format("Azure-%s-Spoke-2", var.company_name)
      cloud          = "Azure"
      cidr           = "10.82.0.0/24"
      region         = var.Azure_region
      network_domain = "Shared"
    }
    GCP_Spoke_1 = {
      name           = format("gcp-%s-spoke-1", lower(var.company_name))
      cloud          = "GCP"
      cidr           = "10.131.0.0/24"
      region         = var.GCP_region
      network_domain = "Prod"
    }
    GCP_Spoke_2 = {
      name           = format("gcp-%s-spoke-2", lower(var.company_name))
      cloud          = "GCP"
      cidr           = "10.132.0.0/24"
      region         = var.GCP_region
      network_domain = "Dev"
    }
    OCI_Spoke_1 = {
      name           = format("oci-%s-Spoke-1", var.company_name)
      cloud          = "OCI"
      cidr           = "10.31.0.0/24"
      region         = var.OCI_region
      network_domain = "Prod"
    }
    OCI_Spoke_2 = {
      name           = format("oci-%s-Spoke-2", var.company_name)
      cloud          = "OCI"
      cidr           = "10.32.0.0/24"
      region         = var.OCI_region
      network_domain = "Dev"
    }
  }

  transits_to_be_built = { for k, v in local.transits : k => v if v.build_transit }
  spokes_to_be_built   = { for k, v in local.spokes : k => v if lookup(local.build_spokes, lower(v.cloud), null) }

  Azure_resource_group = {
    name = format("Azure_%s_Resource_Group", var.company_name)
  }

  accounts = {
    aws   = var.AWS_account,
    azure = var.Azure_account,
    oci   = var.OCI_account,
    gcp   = var.GCP_account,
  }

  build_transit = {
    aws   = var.build_aws_transit,
    azure = var.build_azure_transit,
    oci   = var.build_oci_transit,
    gcp   = var.build_gcp_transit,
  }

  build_spokes = {
    aws   = var.build_aws_spokes,
    azure = var.build_azure_spokes,
    oci   = var.build_oci_spokes,
    gcp   = var.build_gcp_spokes,
  }

  firewall_images = {
    AWS = {
      paloalto   = "Palo Alto Networks VM-Series Next-Generation Firewall (BYOL)"
      fortinet   = "Fortinet FortiGate (BYOL) Next-Generation Firewall"
      checkpoint = "Check Point CloudGuard IaaS Next-Gen Firewall w. Threat Prevention & SandBlast BYOL"
    }
    Azure = {
      paloalto   = "Palo Alto Networks VM-Series Next-Generation Firewall (BYOL)"
      fortinet   = "Fortinet FortiGate (BYOL) Next-Generation Firewall"
      checkpoint = "Check Point CloudGuard IaaS Single Gateway R80.40 - Bring Your Own License"
    }
    GCP = {
      paloalto   = "Palo Alto Networks VM-Series Next-Generation Firewall BYOL"
      fortinet   = "Fortinet FortiGate Next-Generation Firewall (BYOL)"
      checkpoint = "Check Point CloudGuard IaaS Firewall & Threat Prevention (Standalone) (BYOL)"
    }
    OCI = {
      paloalto   = "Palo Alto Networks VM-Series Next Generation Firewall"
      checkpoint = "CloudGuard Next-Gen Firewall with Threat Prevention and SandBlast - BYOL"
    }
  }

  firewall_vendor = lower(var.firewall_vendor)
}
