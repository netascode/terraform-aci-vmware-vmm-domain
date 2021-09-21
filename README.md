<!-- BEGIN_TF_DOCS -->
[![Tests](https://github.com/netascode/terraform-aci-vmware-vmm-domain/actions/workflows/test.yml/badge.svg)](https://github.com/netascode/terraform-aci-vmware-vmm-domain/actions/workflows/test.yml)

# Terraform ACI VMware VMM Domain Module

Manages ACI VMware VMM Domain

Location in GUI:
`Virtual Networking` » `VMware`

## Examples

```hcl
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

```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aci"></a> [aci](#requirement\_aci) | >= 0.2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aci"></a> [aci](#provider\_aci) | >= 0.2.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | VMware VMM domain name. | `string` | n/a | yes |
| <a name="input_access_mode"></a> [access\_mode](#input\_access\_mode) | Access mode. Choices: `read-only`, `read-write`. | `string` | `"read-write"` | no |
| <a name="input_delimiter"></a> [delimiter](#input\_delimiter) | Delimiter (vCenter Port Group). | `string` | `""` | no |
| <a name="input_tag_collection"></a> [tag\_collection](#input\_tag\_collection) | Tag collection. | `bool` | `false` | no |
| <a name="input_vlan_pool"></a> [vlan\_pool](#input\_vlan\_pool) | Vlan pool name. | `string` | n/a | yes |
| <a name="input_vcenters"></a> [vcenters](#input\_vcenters) | List of vCenter hosts. Choices `dvs_version`: `unmanaged`, `5.1`, `5.5`, `6.0`, `6.5`, `6.6`. Default value `dvs_version`: `unmanaged`. Default value `statistics`: false. Default value `mgmt_epg`: `inb`. | <pre>list(object({<br>    name              = string<br>    hostname_ip       = string<br>    datacenter        = string<br>    credential_policy = optional(string)<br>    dvs_version       = optional(string)<br>    statistics        = optional(bool)<br>    mgmt_epg          = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_credential_policies"></a> [credential\_policies](#input\_credential\_policies) | List of vCenter credentials. | <pre>list(object({<br>    name     = string<br>    username = string<br>    password = string<br>  }))</pre> | `[]` | no |
| <a name="input_vswitch"></a> [vswitch](#input\_vswitch) | vSwitch settings. | <pre>object({<br>    cdp_policy          = optional(string)<br>    lldp_policy         = optional(string)<br>    port_channel_policy = optional(string)<br>  })</pre> | `{}` | no |
| <a name="input_inband_epg"></a> [inband\_epg](#input\_inband\_epg) | Inband endpoint group name. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dn"></a> [dn](#output\_dn) | Distinguished name of `vmmDomP` object. |
| <a name="output_name"></a> [name](#output\_name) | VMware VMM domain name. |

## Resources

| Name | Type |
|------|------|
| [aci_rest.infraRsVlanNs](https://registry.terraform.io/providers/netascode/aci/latest/docs/resources/rest) | resource |
| [aci_rest.vmmCtrlrP](https://registry.terraform.io/providers/netascode/aci/latest/docs/resources/rest) | resource |
| [aci_rest.vmmDomP](https://registry.terraform.io/providers/netascode/aci/latest/docs/resources/rest) | resource |
| [aci_rest.vmmRsAcc](https://registry.terraform.io/providers/netascode/aci/latest/docs/resources/rest) | resource |
| [aci_rest.vmmRsMgmtEPg](https://registry.terraform.io/providers/netascode/aci/latest/docs/resources/rest) | resource |
| [aci_rest.vmmRsVswitchOverrideCdpIfPol](https://registry.terraform.io/providers/netascode/aci/latest/docs/resources/rest) | resource |
| [aci_rest.vmmRsVswitchOverrideLacpPol](https://registry.terraform.io/providers/netascode/aci/latest/docs/resources/rest) | resource |
| [aci_rest.vmmRsVswitchOverrideLldpIfPol](https://registry.terraform.io/providers/netascode/aci/latest/docs/resources/rest) | resource |
| [aci_rest.vmmUsrAccP](https://registry.terraform.io/providers/netascode/aci/latest/docs/resources/rest) | resource |
| [aci_rest.vmmVSwitchPolicyCont](https://registry.terraform.io/providers/netascode/aci/latest/docs/resources/rest) | resource |
<!-- END_TF_DOCS -->