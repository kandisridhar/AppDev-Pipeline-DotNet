terraform {
  backend "artifactory" {
    url      = "http://localhost:8081/repository/" 
    repo     = "terraform" 
    subpath  = "dotnet"
    username = "sridhar" 
    password = "sridhar123" 
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.22.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  skip_provider_registration = true
  features {}
}

module "vm" {
  source    = "./modules/vm"
  
}

module "sql" {
  source    = "./modules/sql"
  
}
