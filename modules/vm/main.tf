resource "azurerm_network_security_group" "nsg" {
   for_each = var.virtual-machine
  name                = each.value.nsg_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  security_rule {
    name                       = "door-nsg"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}
resource "azurerm_network_interface" "nic" {
    for_each = var.virtual-machine
  name                = each.value.nic_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_ids[each.value.subnet_key]
    public_ip_address_id = var.publicip_ids[each.value.publicip_key]
    private_ip_address_allocation = "Dynamic"
    
  }
}

  resource "azurerm_network_interface_security_group_association" "nsg_sec_asso" {
    for_each = var.virtual-machine
  network_interface_id      = azurerm_network_interface.nic[each.key].id
  network_security_group_id = azurerm_network_security_group.nsg[each.key].id
}

resource "azurerm_linux_virtual_machine" "virtual-machine" {
    for_each = var.virtual-machine
  name                = each.value.vm_name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  size                = each.value.size
  admin_username      = each.value.admin_username
  network_interface_ids = [
    azurerm_network_interface.nic[each.key].id,
  ]

  disable_password_authentication = false
  admin_password = each.value.admin_password

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
}