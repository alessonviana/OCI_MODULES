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
  compartment_ids        = concat(flatten(data.oci_identity_compartments.this.*.compartments), [{ id = "" }])
  parent_compartment_ids = concat(flatten(data.oci_identity_compartments.this.*.compartments), [{ compartment_id = "" }])
}




locals {
  compartment_id = oci_identity_compartment._.id
}


data "oci_identity_availability_domains" "_" {
  compartment_id = locals.compartment_id
}

data "oci_core_images" "_" {
  compartment_id           = locals.compartment_id
  shape                    = var.shape
  operating_system         = var.operating_system
  operating_system_version = var.operating_system_version
}

resource "oci_core_instance" "_" {
  for_each            = local.nodes
  display_name        = each.value.node_name
  availability_domain = data.oci_identity_availability_domains._.availability_domains[var.availability_domain].name
  compartment_id      = locals.compartment_id
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
  connection {
    host        = self.public_ip
    user        = "ubuntu"
    private_key = tls_private_key.ssh.private_key_pem
  }
  provisioner "remote-exec" {
    inline = [
      "tail -f /var/log/cloud-init-output.log &",
      "cloud-init status --wait >/dev/null",
    ]
  }
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

