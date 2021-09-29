variable "name" {
  description = "VMware VMM domain name."
  type        = string

  validation {
    condition     = can(regex("^[a-zA-Z0-9_.-]{0,64}$", var.name))
    error_message = "Allowed characters: `a`-`z`, `A`-`Z`, `0`-`9`, `_`, `.`, `-`. Maximum characters: 64."
  }
}

variable "access_mode" {
  description = "Access mode. Choices: `read-only`, `read-write`."
  type        = string
  default     = "read-write"

  validation {
    condition     = contains(["read-only", "read-write"], var.access_mode)
    error_message = "Allowed values are `read-only` or `read-write`."
  }
}

variable "delimiter" {
  description = "Delimiter (vCenter Port Group)."
  type        = string
  default     = ""

  validation {
    condition     = var.delimiter == "" || can(regex("^[^a-zA-Z0-9;>\"-*`,-.;/\\{}:?&<]$", var.delimiter))
    error_message = "Maximum characters: 1."
  }
}

variable "tag_collection" {
  description = "Tag collection."
  type        = bool
  default     = false
}

variable "vlan_pool" {
  description = "Vlan pool name."
  type        = string

  validation {
    condition     = can(regex("^[a-zA-Z0-9_.-]{0,64}$", var.vlan_pool))
    error_message = "Allowed characters: `a`-`z`, `A`-`Z`, `0`-`9`, `_`, `.`, `-`. Maximum characters: 64."
  }
}

variable "vswitch_cdp_policy" {
  description = "vSwitch CDP policy name."
  type        = string
  default     = ""

  validation {
    condition     = can(regex("^[a-zA-Z0-9_.-]{0,64}$", var.vswitch_cdp_policy))
    error_message = "Allowed characters: `a`-`z`, `A`-`Z`, `0`-`9`, `_`, `.`, `-`. Maximum characters: 64."
  }
}

variable "vswitch_lldp_policy" {
  description = "vSwitch LLDP policy name."
  type        = string
  default     = ""

  validation {
    condition     = can(regex("^[a-zA-Z0-9_.-]{0,64}$", var.vswitch_lldp_policy))
    error_message = "Allowed characters: `a`-`z`, `A`-`Z`, `0`-`9`, `_`, `.`, `-`. Maximum characters: 64."
  }
}

variable "vswitch_port_channel_policy" {
  description = "vSwitch port channel policy name."
  type        = string
  default     = ""

  validation {
    condition     = can(regex("^[a-zA-Z0-9_.-]{0,64}$", var.vswitch_port_channel_policy))
    error_message = "Allowed characters: `a`-`z`, `A`-`Z`, `0`-`9`, `_`, `.`, `-`. Maximum characters: 64."
  }
}

variable "inband_epg" {
  description = "Inband endpoint group name."
  type        = string
  default     = ""

  validation {
    condition     = can(regex("^[a-zA-Z0-9_.-]{0,64}$", var.inband_epg))
    error_message = "Allowed characters: `a`-`z`, `A`-`Z`, `0`-`9`, `_`, `.`, `-`. Maximum characters: 64."
  }
}

variable "vcenters" {
  description = "List of vCenter hosts. Choices `dvs_version`: `unmanaged`, `5.1`, `5.5`, `6.0`, `6.5`, `6.6`. Default value `dvs_version`: `unmanaged`. Default value `statistics`: false. Default value `mgmt_epg`: `inb`."
  type = list(object({
    name              = string
    hostname_ip       = string
    datacenter        = string
    credential_policy = optional(string)
    dvs_version       = optional(string)
    statistics        = optional(bool)
    mgmt_epg          = optional(string)
  }))
  default = []

  validation {
    condition = alltrue([
      for v in var.vcenters : can(regex("^[a-zA-Z0-9_.-]{0,64}$", v.name))
    ])
    error_message = "Allowed characters `name`: `a`-`z`, `A`-`Z`, `0`-`9`, `_`, `.`, `-`. Maximum characters: 64."
  }

  validation {
    condition = alltrue([
      for v in var.vcenters : can(regex("^[a-zA-Z0-9:][a-zA-Z0-9.:-]{0,254}$", v.hostname_ip))
    ])
    error_message = "Allowed characters `hostname_ip`: `a`-`z`, `A`-`Z`, `0`-`9`, `.`, `:`, `-`. Maximum characters: 254."
  }

  validation {
    condition = alltrue([
      for v in var.vcenters : can(regex("^.{0,512}$", v.datacenter))
    ])
    error_message = "Maximum characters `datacenter`: 512."
  }

  validation {
    condition = alltrue([
      for v in var.vcenters : can(regex("^[a-zA-Z0-9_.-]{0,64}$", v.credential_policy))
    ])
    error_message = "Allowed characters `credential_policy`: `a`-`z`, `A`-`Z`, `0`-`9`, `_`, `.`, `-`. Maximum characters: 64."
  }

  validation {
    condition = alltrue([
      for v in var.vcenters : v.dvs_version == null || try(contains(["unmanaged", "5.1", "5.5", "6.0", "6.5", "6.6"], v.dvs_version), false)
    ])
    error_message = "`dvs_version`: Allowed values are `unmanaged`, `5.1`, `5.5`, `6.0`, `6.5` or `6.6`."
  }

  validation {
    condition = alltrue([
      for v in var.vcenters : v.mgmt_epg == null || try(contains(["inb", "oob"], v.mgmt_epg), false)
    ])
    error_message = "`mgmt_epg`: Allowed values are `inb` or `oob`."
  }
}

variable "credential_policies" {
  description = "List of vCenter credentials."
  type = list(object({
    name     = string
    username = string
    password = string
  }))
  default = []

  validation {
    condition = alltrue([
      for c in var.credential_policies : can(regex("^[a-zA-Z0-9_.-]{0,64}$", c.name))
    ])
    error_message = "Allowed characters `name`: `a`-`z`, `A`-`Z`, `0`-`9`, `_`, `.`, `-`. Maximum characters: 64."
  }

  validation {
    condition = alltrue([
      for c in var.credential_policies : can(regex("^[a-zA-Z0-9\\!#$%()*,-./:;@ _{|}~?&+]{1,128}$", c.username))
    ])
    error_message = "Maximum characters `username`: 128."
  }
}
