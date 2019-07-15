# Configure the Azure Provider
provider "azurerm" { }

# Create a resource group
resource "azurerm_resource_group" "RG" {
  name     = "${var.RGName}"
  location = "${var.location}"
}

# Create a virtual network within the resource group
resource "azurerm_virtual_network" "network" {
  name                = "${var.vNetName}"
  address_space       = ["${var.address_space}"]
  location            = "${azurerm_resource_group.RG.location}"
  resource_group_name = "${azurerm_resource_group.RG.name}"
}

resource "azurerm_subnet" "Front" {
  name                 = "${var.RGName}-subnet-Front"
  resource_group_name  = "${azurerm_resource_group.RG.name}"
  virtual_network_name = "${azurerm_virtual_network.network.name}"
  address_prefix       = "${var.private_subnets}"
}

resource "azurerm_subnet" "Back" {
  name                 = "${var.RGName}-subnet-Back"
  resource_group_name  = "${azurerm_resource_group.RG.name}"
  virtual_network_name = "${azurerm_virtual_network.network.name}"
  address_prefix       = "${var.public_subnets}"
}

resource "azurerm_network_security_group" "NSG" {
  location = "${var.location}"
  name = "${var.RGName}-default-nsg"
  resource_group_name = "${azurerm_resource_group.RG.name}"
}

resource "azurerm_network_security_rule" "inbound_http_cidr" {
  #count = "${length(var.inbound_http_cidr)}"
  resource_group_name = "${azurerm_resource_group.RG.name}"
  network_security_group_name = "${azurerm_network_security_group.NSG.name}"
  access = "Allow"
  source_port_range           = "*"
  destination_address_prefix  = "*"
  destination_port_range = "80"
  direction = "Inbound"
  name = "HTTP"
  priority = 100
  protocol = "TCP"
  #source_address_prefix = "${element(var.inbound_http_cidr, count.index)}"
  source_address_prefixes = ["${var.inbound_http_cidr}"]
}

resource "azurerm_subnet_network_security_group_association" "Front" {
  subnet_id = "${azurerm_subnet.Front.id}"
  network_security_group_id = "${azurerm_network_security_group.NSG.id}"
}

resource "azurerm_subnet_network_security_group_association" "Back" {
  subnet_id = "${azurerm_subnet.Back.id}"
  network_security_group_id = "${azurerm_network_security_group.NSG.id}"
}

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

output "Front_subnet_cidr" {
  value = "${azurerm_subnet.Front.address_prefix}"
}
output "Back_subnet_name" {
  value = "${azurerm_subnet.Back.name}"
}

output "Back_subnet_cidr" {
  value = "${azurerm_subnet.Back.address_prefix}"
}


output "NSG_name" {
  value = "${azurerm_network_security_group.NSG.name}"
}

output "NSG_id" {
  value = "${azurerm_network_security_group.NSG.id}"
}






