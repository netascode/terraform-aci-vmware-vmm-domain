terraform {
  required_providers {
    test = {
      source = "terraform.io/builtin/test"
    }

    aci = {
      source  = "netascode/aci"
      version = ">=0.2.0"
    }
  }
}

module "main" {
  source = "../.."

  name      = "VMW1"
  vlan_pool = "VP1"
}

data "aci_rest" "vmmDomP" {
  dn = "uni/vmmp-VMware/dom-${module.main.name}"

  depends_on = [module.main]
}

resource "test_assertions" "vmmDomP" {
  component = "vmmDomP"

  equal "name" {
    description = "name"
    got         = data.aci_rest.vmmDomP.content.name
    want        = module.main.name
  }
}

data "aci_rest" "infraRsVlanNs" {
  dn = "${data.aci_rest.vmmDomP.id}/rsvlanNs"

  depends_on = [module.main]
}

resource "test_assertions" "infraRsVlanNs" {
  component = "infraRsVlanNs"

  equal "tDn" {
    description = "tDn"
    got         = data.aci_rest.infraRsVlanNs.content.tDn
    want        = "uni/infra/vlanns-[VP1]-dynamic"
  }
}
