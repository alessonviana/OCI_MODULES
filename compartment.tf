resource "oci_identity_compartment" "_" {
  name          = var.name
  description   = var.name
  enable_delete = true
}