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
  address_prefix       = "${var.front_subnet}"
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
  source_address_prefixes = "${var.inbound_http_cidr}"
}

resource "azurerm_subnet_network_security_group_association" "Front" {
  subnet_id = "${azurerm_subnet.Front.id}"
  network_security_group_id = "${azurerm_network_security_group.NSG.id}"
}


resource "azurerm_network_interface" "main" {
  count = "${var.vm_count}"
  name                = "${var.vmName}-nic-${count.index}"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.RG.name}"

  ip_configuration {
    name                          = "ipconfiguration1"
    subnet_id                     = "${azurerm_subnet.Front.id}"
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "main" {
  count = "${var.vm_count}"
  name                  = "${var.vmName}-vm-${count.index}"
  location              = "${var.location}"
  resource_group_name   = "${azurerm_resource_group.RG.name}"
  network_interface_ids = ["${element(azurerm_network_interface.main.*.id, count.index)}"]
  vm_size               = "${var.vm_size}"

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  delete_os_disk_on_termination = true



  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
  storage_os_disk {
    name              = "${var.vmName}-os-disk-${count.index}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "${var.vmName}"
    admin_username = "testadmin"
    admin_password = "Password1234!"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment = "Demo"
  }
}





