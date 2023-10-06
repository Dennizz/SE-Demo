#Build transits
module "transits" {
  source  = "terraform-aviatrix-modules/mc-transit/aviatrix"
  version = "2.5.1"

  #Select all transits in local.transits if build_transit is enabled for them.
  for_each = { for k, v in local.transits : k => v if lookup(local.build_transit, v.cloud, null) }

  cloud                  = each.value.cloud
  cidr                   = each.value.cidr
  region                 = lookup(local.regions, each.value.cloud, null)
  account                = lookup(local.accounts, each.value.cloud, null)
  enable_transit_firenet = lookup(local.enable_transit_firenet, each.value.cloud, null)
}

module "firenet_1" {
  source  = "terraform-aviatrix-modules/mc-firenet/aviatrix"
  version = "v1.5.2"

  for_each = { for k, v in module.transits : k => v if lookup(local.build_transit_firenet, v.cloud, null) }

  transit_module = each.value
  firewall_image = "Palo Alto Networks VM-Series Next-Generation Firewall Bundle 1"
}

#Build spokes
module "spokes" {
  source  = "terraform-aviatrix-modules/mc-spoke/aviatrix"
  version = "1.6.5"

  for_each = local.spokes

  cloud      = each.value.cloud
  name       = each.value.name
  cidr       = each.value.cidr
  region     = lookup(local.regions, each.value.cloud, null)
  account    = lookup(local.accounts, each.value.cloud, null)
  transit_gw = lookup(local.build_transit, each.value.cloud, null) ? module.transits[each.value.cloud].transit_gateway.gw_name : null
  attached   = lookup(local.build_transit, each.value.cloud, null)

  #Optional parameters
  network_domain = try(each.value.network_domain, null)
  insane_mode    = try(each.value.insane_mode, null)

  depends_on = [module.network_domains]
}

#Network domains
module "network_domains" {
  source  = "terraform-aviatrix-modules/mc-network-domains/aviatrix"
  version = "v1.0.0"

  connection_policies = var.domain_connections
  additional_domains  = var.additional_domains
}
