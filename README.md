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
  version = ">= 0.2.0"

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
    mgmt_epg_type     = "oob"
  }]
  credential_policies = [{
    name     = "CP1"
    username = "USER1"
    password = "PASSWORD1"
  }]
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_aci"></a> [aci](#requirement\_aci) | >= 2.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aci"></a> [aci](#provider\_aci) | >= 2.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | VMware VMM domain name. | `string` | n/a | yes |
| <a name="input_access_mode"></a> [access\_mode](#input\_access\_mode) | Access mode. Choices: `read-only`, `read-write`. | `string` | `"read-write"` | no |
| <a name="input_delimiter"></a> [delimiter](#input\_delimiter) | Delimiter (vCenter Port Group). | `string` | `""` | no |
| <a name="input_tag_collection"></a> [tag\_collection](#input\_tag\_collection) | Tag collection. | `bool` | `false` | no |
| <a name="input_vlan_pool"></a> [vlan\_pool](#input\_vlan\_pool) | Vlan pool name. | `string` | n/a | yes |
| <a name="input_vswitch_cdp_policy"></a> [vswitch\_cdp\_policy](#input\_vswitch\_cdp\_policy) | vSwitch CDP policy name. | `string` | `""` | no |
| <a name="input_vswitch_lldp_policy"></a> [vswitch\_lldp\_policy](#input\_vswitch\_lldp\_policy) | vSwitch LLDP policy name. | `string` | `""` | no |
| <a name="input_vswitch_port_channel_policy"></a> [vswitch\_port\_channel\_policy](#input\_vswitch\_port\_channel\_policy) | vSwitch port channel policy name. | `string` | `""` | no |
| <a name="input_vcenters"></a> [vcenters](#input\_vcenters) | List of vCenter hosts. Choices `dvs_version`: `unmanaged`, `5.1`, `5.5`, `6.0`, `6.5`, `6.6`. Default value `dvs_version`: `unmanaged`. Default value `statistics`: false. Allowed values `mgmt_epg_type`: `inb`, `oob`. Default value `mgmt_epg_type`: `inb`. | <pre>list(object({<br>    name              = string<br>    hostname_ip       = string<br>    datacenter        = string<br>    credential_policy = optional(string)<br>    dvs_version       = optional(string, "unmanaged")<br>    statistics        = optional(bool, false)<br>    mgmt_epg_type     = optional(string, "inb")<br>    mgmt_epg_name     = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_credential_policies"></a> [credential\_policies](#input\_credential\_policies) | List of vCenter credentials. | <pre>list(object({<br>    name     = string<br>    username = string<br>    password = string<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dn"></a> [dn](#output\_dn) | Distinguished name of `vmmDomP` object. |
| <a name="output_name"></a> [name](#output\_name) | VMware VMM domain name. |

## Resources

| Name | Type |
|------|------|
| [aci_rest_managed.infraRsVlanNs](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/resources/rest_managed) | resource |
| [aci_rest_managed.vmmCtrlrP](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/resources/rest_managed) | resource |
| [aci_rest_managed.vmmDomP](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/resources/rest_managed) | resource |
| [aci_rest_managed.vmmRsAcc](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/resources/rest_managed) | resource |
| [aci_rest_managed.vmmRsMgmtEPg](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/resources/rest_managed) | resource |
| [aci_rest_managed.vmmRsVswitchOverrideCdpIfPol](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/resources/rest_managed) | resource |
| [aci_rest_managed.vmmRsVswitchOverrideLacpPol](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/resources/rest_managed) | resource |
| [aci_rest_managed.vmmRsVswitchOverrideLldpIfPol](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/resources/rest_managed) | resource |
| [aci_rest_managed.vmmUsrAccP](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/resources/rest_managed) | resource |
| [aci_rest_managed.vmmVSwitchPolicyCont](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/resources/rest_managed) | resource |
<!-- END_TF_DOCS -->