variable "tofusible_inventory" {
  type = any
}

resource "null_resource" "additional" {
  triggers = {
    tofusible_inventory = jsonencode(var.tofusible_inventory)
  }
}