output "ssh-with-k3s-user" {
  value = format(
    "\nssh -o StrictHostKeyChecking=no -i %s -l %s %s\n",
    local_file.ssh_private_key.filename,
    "k3s",
    oci_core_instance._[1].public_ip
  )
}

output "compartment_id" {
  description = "Compartment ocid"
  // This allows the compartment ID to be retrieved from the resource if it exists, and if not to use the data source.
  value = var.compartment_create ? element(concat(oci_identity_compartment.this.*.id, list("")), 0) : lookup(local.compartment_ids[0], "id")
}