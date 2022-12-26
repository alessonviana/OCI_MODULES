output "ssh-with-k3s-user" {
  value = format(
    "\nssh -o StrictHostKeyChecking=no -i %s -l %s %s\n",
    local_file.ssh_private_key.filename,
    "k8s",
    oci_core_instance._[1].public_ip
  )
}

output "compartment_id" {
  description = "Compartment ocid"
  // This allows the compartment ID to be retrieved from the resource if it exists, and if not to use the data source.
  value = var.compartment_create ? element(concat(oci_identity_compartment.this.*.id, list("")), 0) : lookup(local.compartment_ids[0], "id")
}

output "parent_compartment_id" {
  description = "Parent Compartment ocid"
  // This allows the compartment ID to be retrieved from the resource if it exists, and if not to use the data source.
  value = var.compartment_create ? element(concat(oci_identity_compartment.this.*.compartment_id, list("")), 0) : lookup(local.parent_compartment_ids[0], "compartment_id")
}

output "compartment_name" {
  description = "Compartment name"
  value = var.compartment_name
}

output "compartment_description" {
  description = "Compartment description"
  value = var.compartment_description
}

output "ssh-with-ubuntu-user" {
  value = join(
    "\n",
    [for i in oci_core_instance._ :
      format(
        "ssh -o StrictHostKeyChecking=no -l ubuntu -p 22 -i %s %s # %s",
        local_file.ssh_private_key.filename,
        i.public_ip,
        i.display_name
      )
    ]
  )
}