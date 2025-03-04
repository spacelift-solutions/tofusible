# Tofusible

Tofusible is a simple and easy-to-use OpenTofu module and Ansible dynamic inventory (\[Open]**Tofu**\[An]**sible**) made specifically for using OpenTofu with Ansible in Spacelift.

It allows you to create virtual machines in OpenTofu (or Terraform) with any provider you wish and passes that information to Ansible for further configuration.


## How It Works

This repository serves as both the source for the Tofusible OpenTofu module and Ansible Dynamic inventory as well as an example of how to use it.
Each directory contains a `README.md` file with instructions on how to use the module or inventory and all the files within are commented to a high degree to help you understand what is happening.
Feel free to dig around in this repository to see how it works and how you can use it in your own projects.

### High Level Overview

From a high level, the process is as follows:
1. You create virtual machines with OpenTofu - using the provider natively
   - The examples included in this repository use `aws_ec2_instance`'s as examples, but you are not limited to this provider.
2. You use the `tofusible_host` module to gather information about the virtual machines you created.
3. You output the `tofusible_host`s as a list of hosts in OpenTofu (using native OpenTofu outputs).
4. You use the [Spacelift stack dependency](https://docs.spacelift.io/concepts/stack/stack-dependencies#stack-dependencies) feature to pass the output to an Ansible stack.
5. The ansible stack uses the `spacelift` dynamic inventory plugin to read that output and generate a dynamic inventory based off it.
6. Ansible then uses that dynamic inventory to configure the virtual machines you created.

### Directory Structure

This example/source repo has many directories in it, browse around to each directory and check out their README's to see how they work and what they are doing.

- `modules/tofusible_host` - The OpenTofu module that gathers information about the virtual machines you created.
- `stacks/admin` - The Spacelift admin stack that sets up the OpenTofu and Ansible stacks as well as creates the stack dependency between them.
- `stacks/tofu` - The OpenTofu stack that creates the virtual machines.
- `stacks/ansible` - The Ansible stack that configures the virtual machines.
  - This directory also has an `inventory_plugins` directory that contains the `spacelift.py` dynamic inventory plugin.

