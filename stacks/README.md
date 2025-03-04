# The Stacks

Browse each stack to see what it does and how it works.

- `admin` - The Spacelift admin stack that sets up the OpenTofu and Ansible stacks as well as creates the stack dependency between them.
- `tofu` - The OpenTofu stack that creates the virtual machines.
- `ansible` - The Ansible stack that configures the virtual machines.
    - This directory also has an `inventory_plugins` directory that contains the `spacelift.py` dynamic inventory plugin.