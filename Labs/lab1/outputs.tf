output "resource_group_name" {
  value = "${azurerm_resource_group.RG.name}"
}

output "resource_group_id" {
  value = "${azurerm_resource_group.RG.id}"
}

output "virtual_network_name" {
  value = "${azurerm_virtual_network.network.name}"
}

output "virtual_network_id" {
  value = "${azurerm_virtual_network.network.id}"
}

output "vnet_cidr" {
  value = "${azurerm_virtual_network.network.address_space}"
}

output "Front_subnet_name" {
  value = "${azurerm_subnet.Front.name}"
}

output "Front_subnet_id" {
  value = "${azurerm_subnet.Front.id}"
}

output "Front_subnet_cidr" {
  value = "${azurerm_subnet.Front.address_prefix}"
}

output "NSG_name" {
  value = "${azurerm_network_security_group.NSG.name}"
}

output "NSG_id" {
  value = "${azurerm_network_security_group.NSG.id}"
}

output "VM_id" {
  value = "${azurerm_virtual_machine.main.*.id}"
}