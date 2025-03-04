locals {
  null_spec = {
    # Groups tells the dynamic inventory plugin what group to add the host to
    groups = var.groups

    # Extra vars are passed to the ansible inventory raw
    # extra_vars={"var1": "value1", "var2": "value2"}
    # becomes a host variable with var1=>value1, var2=>value2
    extra_vars = var.extra_vars

    # Everything else is part of the ansible behavioral inventory parameters
    # https://docs.ansible.com/ansible/latest/inventory_guide/intro_inventory.html#connecting-to-hosts-behavioral-inventory-parameters
    connection           = var.connection
    host                 = var.host
    port                 = var.port
    user                 = var.user
    password             = var.password
    ssh_private_key_file = var.ssh_private_key_file
    ssh_common_args      = var.ssh_common_args
    sftp_extra_args      = var.sftp_extra_args
    scp_extra_args       = var.scp_extra_args
    ssh_extra_args       = var.ssh_extra_args
    ssh_pipe             = var.ssh_pipe
    ssh_executable       = var.ssh_executable
    become               = var.become
    become_method        = var.become_method
    become_user          = var.become_user
    become_password      = var.become_password
    become_exe           = var.become_exe
    become_flags         = var.become_flags
    shell_type           = var.shell_type
    python_interpreter   = var.python_interpreter
    shell_executable     = var.shell_executable
  }

  # Remove nulls
  spec = {
    for k, v in local.null_spec : k => v if v != null
  }
}

output "spec" {
  value = local.spec
}