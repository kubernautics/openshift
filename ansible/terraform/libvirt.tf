# -[Provider]--------------------------------------------------------------
provider "libvirt" {
  uri   = "qemu+ssh://root@172.10.0.2/system"
}

# -[Variables]-------------------------------------------------------------

variable "hosts" {
  default = 3
}

variable "hostname_format" {
  type    = string
  default = "master%02d.ocp.ministack.dev"
}

#variable "libvirt_provider" {
#  type = string
#}

# -[Output]-------------------------------------------------------------
output "ipv4" {
  value = libvirt_domain.coreos-machine.*.network_interface.0.addresses
}

terraform {
  required_version = ">= 0.12"
}
