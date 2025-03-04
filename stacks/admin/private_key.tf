resource "tls_private_key" "this" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "this" {
  key_name   = "ssh_example_tofu_ansible"
  public_key = tls_private_key.this.public_key_openssh
}

resource "spacelift_context" "ssh_keys" {
  name = "tofusible-ssh-key"

  space_id = var.resource_space_id

  labels = ["tofusible"]
}

resource "spacelift_mounted_file" "ssh_private_key" {
  context_id    = spacelift_context.ssh_keys.id
  content       = base64encode(tls_private_key.this.private_key_pem)
  relative_path = "spacelift.pem"
}

locals {
  private_key_full_path = "/mnt/workspace/${spacelift_mounted_file.ssh_private_key.relative_path}"
}