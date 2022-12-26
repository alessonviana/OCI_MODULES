/*
resource "oci_identity_compartment" "compartment" {
  name          = var.name
  description   = var.name
  compartment_id = var.compartment_id
  enable_delete = true
}

resource "oci_identity_compartment" "this" {
  count          = var.compartment_create ? 1 : 0
  compartment_id = var.compartment_id != null ? var.compartment_id : var.tenancy_ocid
  name           = var.compartment_name
  description    = var.compartment_description
  enable_delete  = var.enable_delete
}

data "oci_identity_compartments" "this" {
  count          = var.compartment_create ? 0 : 1
  compartment_id = var.compartment_id

  filter {
    name   = "name"
    values = [var.compartment_name]
  }
}

locals {
  compartment_ids        = concat(flatten(data.oci_identity_compartments.this.*.compartments), list(map("id", "")))
  parent_compartment_ids = concat(flatten(data.oci_identity_compartments.this.*.compartments), list(map("compartment_id", "")))
}


#locals {
#  compartment_id = var.compartment_id #oci_identity_compartment._.id
#}


data "oci_identity_availability_domains" "availability_domains" {
  compartment_id = var.compartment_id
}

data "oci_core_images" "images" {
  compartment_id           = local.compartment_id
  shape                    = var.shape
  operating_system         = var.operating_system
  operating_system_version = var.operating_system_version
}

resource "oci_core_instance" "instance" {
  for_each            = local.nodes
  display_name        = each.value.node_name
  availability_domain = data.oci_identity_availability_domains._.availability_domains[var.availability_domain].name
  compartment_id      = local.compartment_id
  shape               = var.shape
  shape_config {
    memory_in_gbs = var.memory_in_gbs_per_node
    ocpus         = var.ocpus_per_node
  }
  source_details {
    source_id   = data.oci_core_images._.images[0].id
    source_type = "image"
  }
  create_vnic_details {
    subnet_id  = oci_core_subnet._.id
    private_ip = each.value.ip_address
  }
  metadata = {
    ssh_authorized_keys = join("\n", local.authorized_keys)
  }
}

resource "oci_core_vcn" "vcn" {
  compartment_id = local.compartment_id
  cidr_block     = "192.168.24.0/24"
}

resource "oci_core_internet_gateway" "gateway" {
  compartment_id = local.compartment_id
  vcn_id         = oci_core_vcn._.id
}

resource "oci_core_default_route_table" "route_table" {
  manage_default_resource_id = oci_core_vcn._.default_route_table_id
  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway._.id
  }
}

resource "oci_core_default_security_list" "security_list" {
  manage_default_resource_id = oci_core_vcn._.default_security_list_id
  ingress_security_rules {
    protocol = "all"
    source   = "0.0.0.0/0"
  }
  egress_security_rules {
    protocol    = "all"
    destination = "0.0.0.0/0"
  }
}

resource "oci_core_subnet" "subnet" {
  compartment_id    = local.compartment_id
  cidr_block        = var.cidr_block
  vcn_id            = oci_core_vcn._.id
  route_table_id    = oci_core_default_route_table._.id
  security_list_ids = [oci_core_default_security_list._.id]
}

locals {
  nodes = {
    for i in range(1, 1 + var.how_many_nodes) :
    i => {
      node_name  = format("node%d", i)
      ip_address = format("192.168.24.%d", 192 + i)
      role       = i == 1 ? "controlplane" : "worker"
    }
  }
} 

*/

terraform {
  required_version = ">= 0.12" // terraform version below 0.12 is not tested/supported with this module
  required_providers {
    oci = {
      version = ">= 3.27" // force downloading oci-provider compatible with terraform v0.12
    }
  }
}

########################
# Compartment
########################

resource "oci_identity_compartment" "this" {
  count          = var.compartment_create ? 1 : 0
  compartment_id = var.compartment_id != null ? var.compartment_id : var.tenancy_ocid
  name           = var.compartment_name
  description    = var.compartment_description
  enable_delete  = var.enable_delete
}

data "oci_identity_compartments" "this" {
  count          = var.compartment_create ? 0 : 1
  compartment_id = var.compartment_id

  filter {
    name   = "name"
    values = [var.compartment_name]
  }
}

locals {
  compartment_ids        = concat(flatten(data.oci_identity_compartments.this.*.compartments), list(map("id", "")))
  parent_compartment_ids = concat(flatten(data.oci_identity_compartments.this.*.compartments), list(map("compartment_id", "")))
}