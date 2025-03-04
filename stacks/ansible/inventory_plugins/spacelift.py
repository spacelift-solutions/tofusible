#!/usr/bin/python
# -*- coding: utf-8 -*-

# Local Testing
#
# export TOFUSIBLE_INVENTORY='[{"groups":["web","ohio.columbus"],"host":"JOEY_TEST","password":"this_is_a_test","port":22,"ssh_key":null,"user":"tofu"}]'
# ansible-inventory -i spacelift.yml --playbook-dir ./ --list

import os
import json

from ansible.plugins.inventory import BaseInventoryPlugin
from ansible.errors import AnsibleParserError, AnsibleError

# Format Documentation: https://docs.ansible.com/ansible/latest/dev_guide/developing_modules_documenting.html

DOCUMENTATION = r'''
    name: spacelift
    plugin_type: inventory
    short_description: Reads Ansible Generated Inventory From OpenTofu
    description: Reads Ansible Generated Inventory From OpenTofu
    options:
      plugin:
          description: Name of the plugin
          required: true
          choices: ['spacelift']
      environment_variables:
          description: Environment Variables to parse for 
          required: true
          type: list
          elements: str
'''


def read_variables(variables):
    _vars = {}
    try:
        for variable in variables:
            _vars[variable] = json.loads(os.environ[variable])
    except KeyError as e:
        raise AnsibleError(
            'Environment variable not found: {}'.format(e))
    except json.JSONDecodeError as e:
        raise AnsibleError(
            'Error parsing JSON: {}'.format(e))
    return _vars


class InventoryModule(BaseInventoryPlugin):
    NAME = "spacelift"

    def __init__(self):
        super().__init__()

    def verify_file(self, path):
        valid = False
        if super(InventoryModule, self).verify_file(path):
            if path.endswith(('spacelift.yml', 'spacelift.yaml')):
                valid = True
        return valid

    def parse(self, inventory, loader, path, cache=True):
        super(InventoryModule, self).parse(inventory, loader, path, cache)
        self._read_config_data(path)

        try:
            _ = self.get_option("plugin")
            variables = self.get_option("environment_variables")
        except Exception as e:
            raise AnsibleParserError(
                'All correct options required: {}'.format(e))

        i = read_variables(variables)

        for variable in i.keys():
            for host in i[variable]:

                # Add all the groups and hosts
                for group in host["groups"]:

                    # Process groups with dots in them
                    if "." in group:
                        last_group = None
                        for child in group.split("."):
                            self.inventory.add_group(child)
                            if last_group:
                                self.inventory.add_child(last_group, child)
                            last_group = child
                        self.inventory.add_host(host=host["host"], group=last_group)

                    # Process groups without dots in them
                    else:
                        self.inventory.add_group(group)
                        self.inventory.add_host(host=host["host"], group=group)

                # Add the host vars
                self.build_host_vars(host)


    def build_host_vars(self, host):
        for var in host.keys():
            if var not in ["extra_vars", "groups"]:
                self.inventory.set_variable(host["host"], "ansible_"+var, host[var])
            elif var == "extra_vars":
                for key in host["extra_vars"].keys():
                    self.inventory.set_variable(host["host"], key, host["extra_vars"][key])