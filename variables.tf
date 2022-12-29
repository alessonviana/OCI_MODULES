#####################
# compartment
#####################

variable "name" {
  type    = string
  default = "k3s"
}


##################
# instance
##################

variable "availability_domain" {
  type    = number
  default = 0
}

variable "shape" {
  type    = string
  default = "VM.Standard.A1.Flex"
}

variable "operating_system" {
  type  = string
  default  = "Canonical Ubuntu"
}

variable "operating_system_version" {
  type  = string
  default  = "20.04"
}

variable "memory_in_gbs_per_node" {
  type    = number
  default = 4
}
 variable "ocpus_per_node" {
  type    = number
  default = 1
}

 variable "how_many_nodes" {
  type    = number
  default = 3
}

 variable "cidr_block" {
  type    = string
  default = "10.10.10.0/23"
}

 variable "cidr_block_subnet" {
  type    = string
  default = "10.10.10.0/24"
}