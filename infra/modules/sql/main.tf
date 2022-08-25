resource "azurerm_storage_account" "main" {
  name                     = var.storage_name
  resource_group_name      = var.rg_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_sql_server" "main" {
  name                         = var.sql_server_name
  resource_group_name          = var.rg_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = "sqluser"
  administrator_login_password = "Dotnet@24056"
  
resource "azurerm_sql_firewall_rule" "main" {
  name                = "FirewallRule1"
  resource_group_name = var.rg_name
  server_name         = azurerm_sql_server.main.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "255.255.255.255"
}

  tags = {
    environment = "development"
  }
}
