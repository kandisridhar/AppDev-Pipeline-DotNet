terraform {
  backend "artifactory" {
    url      = "http://localhost:8081/repository/" 
    repo     = "terraform" 
    subpath  = "dotnet"
    username = "admin" 
    password = "admin" 
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

module "webapp" {
  source    = "./modules/webapp"
  
}

module "sql" {
  source    = "./modules/sql"
  
}
