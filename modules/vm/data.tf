# data "azurerm_subnet" "subnet" {
#     for_each = var.virtual-machine
#   name                 = each.value.subnet_name 
#   virtual_network_name = each.value.virtual_network_name
#   resource_group_name  = each.value.resource_group_name
# }
# data "azurerm_public_ip" "publicip" {

#   for_each = var.virtual-machine
#   name                = each.value.publicip_name
#   resource_group_name = each.value.resource_group_name
# }

