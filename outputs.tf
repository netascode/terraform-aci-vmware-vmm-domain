output "dn" {
  value       = aci_rest.vmmDomP.id
  description = "Distinguished name of `vmmDomP` object."
}

output "name" {
  value       = aci_rest.vmmDomP.content.name
  description = "VMware VMM domain name."
}
