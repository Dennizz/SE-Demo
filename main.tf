#Build transits, firenet and peering
module "backbone" {
  source  = "terraform-aviatrix-modules/backbone/aviatrix"
  version = "v1.2.2"

  global_settings = {
    transit_accounts = {
      azure = var.Azure_account,
      oci   = var.OCI_account,
      aws   = var.AWS_account,
      gcp   = var.GCP_account,
    }

    firenet_firewall_image = {
      aws   = local.firewall_images.AWS[local.firewall_vendor],
      azure = local.firewall_images.Azure[local.firewall_vendor],
      gcp   = local.firewall_images.GCP[local.firewall_vendor],
      oci   = var.build_oci_firenet ? local.firewall_images.OCI[local.firewall_vendor] : null
    }
  }

  transit_firenet = local.transits_to_be_built
}

#Build spokes
module "spokes" {
  source  = "terraform-aviatrix-modules/mc-spoke/aviatrix"
  version = "1.6.6"

  for_each = local.spokes

  cloud      = each.value.cloud
  name       = each.value.name
  cidr       = each.value.cidr
  region     = each.value.region
  ha_gw      = var.high_availability
  account    = lookup(local.accounts, lower(each.value.cloud), null)
  transit_gw = try(lookup(module.backbone.region_transit_map, each.value.region)[0], null)
  attached   = lookup(local.build_transit, lower(each.value.cloud), null)

  #Optional parameters
  network_domain = try(each.value.network_domain, null)
  insane_mode    = try(each.value.insane_mode, null)

  depends_on = [
    module.network_domains,
    module.backbone
  ]
}

#Network domains
module "network_domains" {
  source  = "terraform-aviatrix-modules/mc-network-domains/aviatrix"
  version = "v1.0.0"

  connection_policies = var.domain_connections
  additional_domains  = var.additional_domains
}
