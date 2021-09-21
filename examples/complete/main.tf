module "aci_vmware_vmm_domain" {
  source  = "netascode/vmware-vmm-domain/aci"
  version = ">= 0.0.1"

  name           = "VMW1"
  access_mode    = "read-only"
  delimiter      = "="
  tag_collection = true
  vlan_pool      = "VP1"
  vcenters = [{
    name              = "VC1"
    hostname_ip       = "1.1.1.1"
    datacenter        = "DC"
    credential_policy = "CP1"
    dvs_version       = "6.5"
    statistics        = true
    mgmt_epg          = "oob"
  }]
  credential_policies = [{
    name     = "CP1"
    username = "USER1"
    password = "PASSWORD1"
  }]
  vswitch = {
    cdp_policy          = "CDP1"
    lldp_policy         = "LLDP1"
    port_channel_policy = "PC1"
  }
}
