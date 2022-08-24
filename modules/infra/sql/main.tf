resource "azurerm_storage_account" "main" {
  name                     = "dotnetstorage"
  resource_group_name      = "ranjith"
  location                 = "eastus"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_sql_server" "example" {
  name                         = "dotnetcoresql"
  resource_group_name          = "ranjith"
  location                     = "eastus"
  version                      = "12.0"
  administrator_login          = "sqluser"
  administrator_login_password = "Dotnet@2405"

  tags = {
    environment = "development"
  }
}
