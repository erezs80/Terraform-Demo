variable "RGName" {
    description = "Azure RG name"
}
variable "location" {
    description = "Azure region"
}
variable "vNetName" {
    description = "Azure vNet name"
}
variable "address_space" {
    description = "vNet CIDR space"
}
variable "private_subnets" {
    description = "vNet private subnet"
}
variable "public_subnets" {
    description = "vNet public subnet"
}
variable "inbound_http_cidr" {
    description = "NSG rule http cidr list"
    type = "list"
}

