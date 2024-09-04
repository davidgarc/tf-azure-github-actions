terraform {
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azuread" {
  # Configuration options
}

provider "azurerm" {
  features {}
}

resource "azuread_application" "github_actions" {
  display_name = "GitHub Actions - packer-azure-actions"
}

resource "azuread_service_principal" "github_actions" {
  client_id = azuread_application.github_actions.client_id
}

# Create a federated identity credential for the GitHub Actions app
resource "azuread_application_federated_identity_credential" "github_actions" {
  application_id = azuread_application.github_actions.id
  display_name   = "github-actions-federated"
  description    = "Federated identity for GitHub Actions"
  audiences      = ["api://AzureADTokenExchange"]
  issuer         = "https://token.actions.githubusercontent.com"
  subject        = "repo:davidgarc/packer-azure-actions:environment:Prod"
}

# create resource group for packer demo project
resource "azurerm_resource_group" "packer_demo" {
  name     = "packer-demo"
  location = "South Central US"
}

# create compute gallery
resource "azurerm_shared_image_gallery" "packer_demo" {
  name                = "packer_demo_gallery"
  resource_group_name = azurerm_resource_group.packer_demo.name
  location            = azurerm_resource_group.packer_demo.location
  description         = "Shared Image Gallery for Packer Demo"
}

# add role contributor to the service principal
resource "azurerm_role_assignment" "contributor" {
  scope                = azurerm_resource_group.packer_demo.id
  role_definition_name = "Contributor"
  principal_id         = azuread_service_principal.github_actions.id
}
