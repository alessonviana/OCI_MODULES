/*
Available flex shapes:
"VM.Optimized3.Flex"  # Intel Ice Lake
"VM.Standard3.Flex"   # Intel Ice Lake
"VM.Standard.A1.Flex" # Ampere Altra
"VM.Standard.E3.Flex" # AMD Rome
"VM.Standard.E4.Flex" # AMD Milan


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

variable "tenancy_ocid" {
  type = string
  description = "(Deprecated) The OCID of the tenancy."
  default = null
}

variable "compartment_id" {
  type = string
  description = "The OCID of the parent compartment containing the compartment. Allow for sub-compartments creation"
  default     = null
}

variable "compartment_name" {
  type = string
  description = "The name you assign to the compartment during creation. The name must be unique across all compartments in the tenancy. "
  default     = null
}

// The description is only used if compartment_create = true.
variable "compartment_description" {
  type = string
  description = "The description you assign to the compartment. Does not have to be unique, and it's changeable. "
  default     = null
}

variable "compartment_create" {
  type = bool
  description = "(Deprecated) Create the compartment or not. If true, the compartment will be managed by this module, and the user must have permissions to create the compartment; If false, compartment data will be returned about the compartment if it exists, if not found, then an empty string will be returned for the compartment ID."
  default     = true
}

variable "enable_delete" {
  type = bool
  description = "Enable compartment delete on destroy. If true, compartment will be deleted when `terraform destroy` is executed; If false, compartment will not be deleted on `terraform destroy` execution"
  default     = false
}
*/

variable "tenancy_ocid" {
  type = string
  description = "(Deprecated) The OCID of the tenancy."
  default = null
}

variable "compartment_id" {
  type = string
  description = "The OCID of the parent compartment containing the compartment. Allow for sub-compartments creation"
  default     = null
}

variable "compartment_name" {
  type = string
  description = "The name you assign to the compartment during creation. The name must be unique across all compartments in the tenancy. "
  default     = null
}

// The description is only used if compartment_create = true.
variable "compartment_description" {
  type = string
  description = "The description you assign to the compartment. Does not have to be unique, and it's changeable. "
  default     = null
}

variable "compartment_create" {
  type = bool
  description = "(Deprecated) Create the compartment or not. If true, the compartment will be managed by this module, and the user must have permissions to create the compartment; If false, compartment data will be returned about the compartment if it exists, if not found, then an empty string will be returned for the compartment ID."
  default     = true
}

variable "enable_delete" {
  type = bool
  description = "Enable compartment delete on destroy. If true, compartment will be deleted when `terraform destroy` is executed; If false, compartment will not be deleted on `terraform destroy` execution"
  default     = false
}