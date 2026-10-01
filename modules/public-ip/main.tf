resource "azurerm_public_ip" "publicip" {
    for_each = var.publicip
  name                = each.value.publicip_name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  allocation_method   = each.value.allocation_method
}