# The OpenTofu Stack

This stack creates the virtual machines in OpenTofu and then generates an output that the Ansible stack can use to configure the virtual machines.

## How It Works

1. We create the virtual machines in OpenTofu using the `aws_ec2_instance` resource.
2. We use the `tofusible_host` module to gather information about the virtual machines we created.
3. We output the `tofusible_host`s as a list of hosts in OpenTofu (using native OpenTofu outputs).

Check out the readme in `modules/tofusible_host` to learn more about the module and how to configure it.

Take a look at the OpenTofu code for more details.