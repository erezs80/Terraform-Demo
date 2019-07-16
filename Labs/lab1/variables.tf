variable "RGName" {
    description = "Azure RG name"
}
variable "location" {
    description = "Azure region"
}
variable "vNetName" {
    description = "Azure vNet name"
}

variable "vmName" {
    description = "VMName name"
}

variable "vm_size" {
    description = "VM size"
}

variable "vm_count" {
    description = "number of VM's"
}
variable "address_space" {
    description = "vNet CIDR space"
}
variable "front_subnet" {
    description = "vNet front subnet"
}
variable "inbound_http_cidr" {
    description = "NSG rule http cidr list"
    type = "list"
}

