provider "azurerm" {
}

resource "azurerm_resource_group" "dns_management" {
  name     = "dns-managment"
  location = "West Europe"
}

resource "azurerm_dns_zone" "mydomaincom" {
  name                = "mydomain.com" # replace with your domain
  resource_group_name = "${azurerm_resource_group.dns_management.name}"
}

resource "azurerm_dns_a_record" "projectmydomain" {
  name                = "project"
  zone_name           = "${azurerm_dns_zone.mydomaincom.name}"
  resource_group_name = "${azurerm_resource_group.dns_management.name}"
  ttl                 = 300
  records             = ["127.0.0.1"]
}

resource "azurerm_dns_cname_record" "awesomemydomain" {
  name                = "awesome"
  zone_name           = "${azurerm_dns_zone.mydomaincom.name}"
  resource_group_name = "${azurerm_resource_group.dns_management.name}"
  ttl                 = 300
  record              = "project.mydomain.com"
}