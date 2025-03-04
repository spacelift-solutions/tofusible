# The Admin Stack

This admin stack creates the OpenTofu and Ansible stacks as well as creates the stack dependency between them.
This is not _super_ necessary but it makes explaining all the parts of the process easier because you can see how the ansible and the opentofu stacks are confugured.

Feel free to look at the OpenTofu files in this stack to see how the child stacks should be configured.

## Spin this thing up

You can create an admin stack and point it to this directory and it will setup the whole `tofusible` show so you can see how it works.

You simply need to configure the variables in `variables.tf` to match your environment and youre off to the races!
Just make sure you set it as an `admin` stack and attach an AWS integration to it!