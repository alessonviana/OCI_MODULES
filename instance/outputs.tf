#output "ssh-with-k3s-user" {
#  value = format(
#    "\nssh -o StrictHostKeyChecking=no -i %s -l %s %s\n",
#    local_file.ssh_private_key.filename,
#    "k3s",
#    oci_core_instance._[1].public_ip
#  )
#}
