locals {
  #Gateway names, derived from var.company_name
  transits = {
    AWS = {
      name          = format("AWS-%s-Transit", var.company_name)
      build_transit = var.build_aws_transit
    }
    Azure = {
      name = format("Azure-%s-Transit", var.company_name)
    }
    GCP = {
      name = format("GCP-%s-transit", var.company_name)
    }
    OCI = {
      name = format("OCI-%s-VCN-Transit", var.company_name)
    }
  }

  spokes = {
    AWS_Spoke_1 = {
      name  = format("%s-AWS-Spoke-GW-1", var.company_name)
      cloud = "AWS"
      cidr  = "10.180.0.0/24"

      #Additional fields that are supported on spokes (can be added to any of them):
      insane_mode = true
      #network_domain = "Prod"
    }
    AWS_Spoke_2 = {
      name = format("%s-AWS-Spoke-GW-2", var.company_name)
    }
    Azure_Spoke_1 = {
      name = format("Azure-%s-VNET-Spoke-1", var.company_name)
    }
    Azure_Spoke_2 = {
      name = format("Azure-%s-VNET-Spoke-2", var.company_name)
    }
    GCP_Spoke_1 = {
      name = format("gcp-%s-vnet-spoke-1", var.company_name)
    }
    GCP_Spoke_2 = {
      name = format("gcp-%s-vnet-spoke-2", var.company_name)
    }
    OCI_Spoke_1 = {
      name = format("oci-%s-VCN-Spoke-1", var.company_name)
    }
    OCI_Spoke_2 = {
      name = format("oci-%s-VCN-Spoke-2", var.company_name)
    }
  }

  Azure_Resource_Group = {
    name = format("Azure_%s_Resource_Group", var.company_name)
  }

  regions = {
    aws   = var.AWS_Region,
    azure = var.Azure_Region,
  }

  accounts = {
    aws   = var.AWS_Account,
    azure = var.Azure_Account,
  }

  build_transit = {
    aws   = var.build_aws_transit
    azure = var.build_azure_transit
    gcp   = var.build_gcp_transit
    oci   = var.build_oci_transit
  }

  build_transit_firenet = {
    aws   = var.build_aws_firenet
    azure = var.build_azure_firenet
    gcp   = var.build_gcp_firenet
    oci   = var.build_oci_firenet
  }
}
