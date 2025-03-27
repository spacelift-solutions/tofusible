# Ansible Stack

This stack configures the virtual machines created in the OpenTofu stack.

The `tofusible.yml` file contains the dynamic inventory plugin to use, as well as configures it.
The `inventory_plugins` directory is where the `tofusible.py` dynamic inventory plugin is stored.
The `playbook.yml` file is the playbook that will be run on the virtual machines.