variable "compartment_id" {
  type = string
  description = "The OCID of the parent compartment containing the compartment. Allow for sub-compartments creation"
  default     = null
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
  default = 6
}

variable "ocpus_per_node" {
  type    = number
  default = 1
}