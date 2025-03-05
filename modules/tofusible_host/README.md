# Tofusible_host Module

The `tofusible_host` module is a simple OpenTofu module that gathers information about the virtual machines you created with OpenTofu.
It is used in conjunction with the `spacelift` dynamic inventory plugin to pass that information to Ansible for further configuration.

This module ensures the hosts are formatted in a predictable way.
This is important because different resources across the OpenTofu community can create hosts in different ways, so this module ensures that the hosts are formatted in a way that the `spacelift` dynamic inventory plugin can read them.
As an example, an `aws_ec2_instance`'s `public_ip` is **not** the same as a `digitalocean_droplet`'s `ipv4_address` attribute.

## Variables

This module has many variables but only two are different from the ansible behavioral inventory parameters (we will get to that).

### `groups`

Groups tells the dynamic inventory plugin what group to add the host to. It also supports dot (`.`) notation for nested groups.

Say you create a host with the following information:
```hcl
module "tofusible_host_1" {
  source  = "spacelift.io/spacelift-solutions/tofusible-host/spacelift"

  host   = aws_ec2_instance.example.public_ip
  groups = ["web", "production", "servers.linux"]
}
```

This host would be added to the following groups in ansible:
- `web`
- `production`
- `linux` and it will ensure the `linux` group is nested under the `servers` group.

### `extra_vars`

Extra vars are extra host variables you can use in your ansible playbook. These can be anything.

Say you create a host with the following information:
```hcl
module "tofusible_host_1" {
  source  = "spacelift.io/spacelift-solutions/tofusible-host/spacelift"

  host       = aws_ec2_instance.example.public_ip
  extra_vars = {
    subatomic = "particles"
    spacelift = "awesome"
  }
}
```
When the dynamic inventory is generated, you can use anything passed to `extra_vars` in your ansible playbook via `hostvars[inventory_hostname].subatomic` or `hostvars[inventory_hostname].spacelift`.

### Ansible Behavioral Inventory Parameters

All of the Ansible behavioral inventory parameters are supported by this module. You can read more about them [here](https://docs.ansible.com/ansible/latest/inventory_guide/intro_inventory.html#connecting-to-hosts-behavioral-inventory-parameters).
They can be passed into the module as their name minus the `ansible_` prefix.

For example, if you wanted to set the `ansible_host` variable for a host, you would pass it in like so:
```hcl
module "tofusible_host_1" {
  source  = "spacelift.io/spacelift-solutions/tofusible-host/spacelift"

  host = "192.168.1.1"
  user = "ubuntu"
}
```
When the dynamic inventory reads that, it will automatically set the `ansible_host` and `ansible_user` variable for you.