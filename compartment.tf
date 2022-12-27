/*
resource "oci_identity_compartment" "_" {
  #compartment_create          = var.compartment_create 
  compartment_id = var.compartment_id != null ? var.compartment_id : var.tenancy_ocid
  name           = var.compartment_name
  description    = var.compartment_description
  enable_delete  = var.enable_delete
}

data "oci_identity_compartments" "_" {
  count          = var.compartment_create ? 0 : 1
  compartment_id = var.compartment_id

  filter {
    name   = "name"
    values = [var.compartment_name]
  }
}

locals {
  compartment_ids        = concat(flatten(data.oci_identity_compartments._.*.compartments), [{ id = "" }])
  parent_compartment_ids = concat(flatten(data.oci_identity_compartments._.*.compartments), [{ compartment_id = "" }])
}
*/