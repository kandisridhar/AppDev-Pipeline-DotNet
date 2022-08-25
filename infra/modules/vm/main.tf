resource "azurerm_virtual_network" "main" {
  name                = var.vnet_name
  address_space       = var.vnet_cidr
  location            = var.location
  resource_group_name = var.rg_name
}

resource "azurerm_subnet" "internal" {
  name                 = var.subnet_name
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = var.subnet_cidr
}

resource "azurerm_public_ip" "public_ip" {
  name                = var.publicip_name
  resource_group_name = var.rg_name
  location            = var.location
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "main" {
  name                = var.network_interface_name
  location            = var.location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
	public_ip_address_id          = azurerm_public_ip.public_ip.id
  }
}
resource "azurerm_network_security_group" "main" {
  name                = var.nsg_name
  location            = var.location
  resource_group_name = var.rg_name

  security_rule {
    name                       = "allow_ssh_sg"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface_security_group_association" "association" {
  network_interface_id      = azurerm_network_interface.main.id
  network_security_group_id = azurerm_network_security_group.main.id
}

resource "azurerm_windows_virtual_machine" "main" {
  name                  = var.vm_name
  location              = var.location
  resource_group_name   = var.rg_name
  network_interface_ids = [azurerm_network_interface.main.id]
  size                  = "Standard_DS1_v2"
  admin_username        = "dotnet"
  admin_password        = "Devops@123456"
  computer_name         = "dotnetcore"
	
   os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  plan {
   name = "belvmsrviis01"
   publisher = "belindaczsro1588885355210"
   product = "belvmsrviis"
  }

  source_image_reference {
    publisher = "belindaczsro1588885355210"
    offer     = "belvmsrviis"
    sku       = "belvmsrviis01"
    version   = "latest"
  }
}




