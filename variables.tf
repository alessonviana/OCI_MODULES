/*
Available flex shapes:
"VM.Optimized3.Flex"  # Intel Ice Lake
"VM.Standard3.Flex"   # Intel Ice Lake
"VM.Standard.A1.Flex" # Ampere Altra
"VM.Standard.E3.Flex" # AMD Rome
"VM.Standard.E4.Flex" # AMD Milan
*/


variable "name" {
  type    = string
  default = "k3s"
}

variable "operating_system" {
  type  = string
  default  = "Canonical Ubuntu"
}

variable "operating_system_version" {
  type  = string
  default  = "20.04"
}

variable "shape" {
  type    = string
  default = "VM.Standard.A1.Flex"
}

variable "how_many_nodes" {
  type    = number
  default = 3
}

variable "availability_domain" {
  type    = number
  default = 0
}

variable "ocpus_per_node" {
  type    = number
  default = 1
}

variable "memory_in_gbs_per_node" {
  type    = number
  default = 6
}

variable "cidr_block" {
  type  = string
  default  = "192.168.24.0/24"
} 