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

  name                        = "VMW1"
  access_mode                 = "read-only"
  delimiter                   = "="
  tag_collection              = true
  vlan_pool                   = "VP1"
  vswitch_cdp_policy          = "CDP1"
  vswitch_lldp_policy         = "LLDP1"
  vswitch_port_channel_policy = "PC1"
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

  equal "accessMode" {
    description = "accessMode"
    got         = data.aci_rest.vmmDomP.content.accessMode
    want        = "read-only"
  }

  equal "delimiter" {
    description = "delimiter"
    got         = data.aci_rest.vmmDomP.content.delimiter
    want        = "="
  }

  equal "enableTag" {
    description = "enableTag"
    got         = data.aci_rest.vmmDomP.content.enableTag
    want        = "yes"
  }

  equal "mode" {
    description = "mode"
    got         = data.aci_rest.vmmDomP.content.mode
    want        = "default"
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

data "aci_rest" "vmmRsVswitchOverrideLldpIfPol" {
  dn = "${data.aci_rest.vmmDomP.id}/vswitchpolcont/rsvswitchOverrideLldpIfPol"

  depends_on = [module.main]
}

resource "test_assertions" "vmmRsVswitchOverrideLldpIfPol" {
  component = "vmmRsVswitchOverrideLldpIfPol"

  equal "tDn" {
    description = "tDn"
    got         = data.aci_rest.vmmRsVswitchOverrideLldpIfPol.content.tDn
    want        = "uni/infra/lldpIfP-LLDP1"
  }
}

data "aci_rest" "vmmRsVswitchOverrideCdpIfPol" {
  dn = "${data.aci_rest.vmmDomP.id}/vswitchpolcont/rsvswitchOverrideCdpIfPol"

  depends_on = [module.main]
}

resource "test_assertions" "vmmRsVswitchOverrideCdpIfPol" {
  component = "vmmRsVswitchOverrideCdpIfPol"

  equal "tDn" {
    description = "tDn"
    got         = data.aci_rest.vmmRsVswitchOverrideCdpIfPol.content.tDn
    want        = "uni/infra/cdpIfP-CDP1"
  }
}

data "aci_rest" "vmmRsVswitchOverrideLacpPol" {
  dn = "${data.aci_rest.vmmDomP.id}/vswitchpolcont/rsvswitchOverrideLacpPol"

  depends_on = [module.main]
}

resource "test_assertions" "vmmRsVswitchOverrideLacpPol" {
  component = "vmmRsVswitchOverrideLacpPol"

  equal "tDn" {
    description = "tDn"
    got         = data.aci_rest.vmmRsVswitchOverrideLacpPol.content.tDn
    want        = "uni/infra/lacplagp-PC1"
  }
}

data "aci_rest" "vmmCtrlrP" {
  dn = "${data.aci_rest.vmmDomP.id}/ctrlr-VC1"

  depends_on = [module.main]
}

resource "test_assertions" "vmmCtrlrP" {
  component = "vmmCtrlrP"

  equal "dvsVersion" {
    description = "dvsVersion"
    got         = data.aci_rest.vmmCtrlrP.content.dvsVersion
    want        = "6.5"
  }

  equal "hostOrIp" {
    description = "hostOrIp"
    got         = data.aci_rest.vmmCtrlrP.content.hostOrIp
    want        = "1.1.1.1"
  }

  equal "inventoryTrigSt" {
    description = "inventoryTrigSt"
    got         = data.aci_rest.vmmCtrlrP.content.inventoryTrigSt
    want        = "untriggered"
  }

  equal "mode" {
    description = "mode"
    got         = data.aci_rest.vmmCtrlrP.content.mode
    want        = "default"
  }

  equal "name" {
    description = "name"
    got         = data.aci_rest.vmmCtrlrP.content.name
    want        = "VC1"
  }

  equal "port" {
    description = "port"
    got         = data.aci_rest.vmmCtrlrP.content.port
    want        = "0"
  }

  equal "rootContName" {
    description = "rootContName"
    got         = data.aci_rest.vmmCtrlrP.content.rootContName
    want        = "DC"
  }

  equal "scope" {
    description = "scope"
    got         = data.aci_rest.vmmCtrlrP.content.scope
    want        = "vm"
  }

  equal "statsMode" {
    description = "statsMode"
    got         = data.aci_rest.vmmCtrlrP.content.statsMode
    want        = "enabled"
  }
}

data "aci_rest" "vmmUsrAccP" {
  dn = "${data.aci_rest.vmmDomP.id}/usracc-CP1"

  depends_on = [module.main]
}

resource "test_assertions" "vmmUsrAccP" {
  component = "vmmUsrAccP"

  equal "name" {
    description = "name"
    got         = data.aci_rest.vmmUsrAccP.content.name
    want        = "CP1"
  }

  equal "usr" {
    description = "usr"
    got         = data.aci_rest.vmmUsrAccP.content.usr
    want        = "USER1"
  }
}

data "aci_rest" "vmmRsAcc" {
  dn = "${data.aci_rest.vmmCtrlrP.id}/rsacc"

  depends_on = [module.main]
}

resource "test_assertions" "vmmRsAcc" {
  component = "vmmRsAcc"

  equal "tDn" {
    description = "tDn"
    got         = data.aci_rest.vmmRsAcc.content.tDn
    want        = "uni/vmmp-VMware/dom-VMW1/usracc-CP1"
  }
}
