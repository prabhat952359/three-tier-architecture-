output "publicip_ids" {
  value = {
    for key, pip in azurerm_public_ip.publicip :
    key => pip.id
  }
}