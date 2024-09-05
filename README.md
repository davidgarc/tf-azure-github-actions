# Packer Azure Actions Project

This project demonstrates the setup of Azure resources for GitHub Actions OIDC integration. It also creates an Azure Shared Image Gallery that can be used to store and manage VM images. It pre-creates an image that Packer can then use to create versions of the image.

## Overview

This Terraform configuration sets up the necessary Azure resources and permissions for a GitHub Actions workflow to build and manage VM images using Packer. It includes:

- Azure AD Application and Service Principal for GitHub Actions
- Azure Resource Group for the Packer demo
- Azure Compute Gallery (Shared Image Gallery)
- Role assignments for the Service Principal
- Federated identity credential for GitHub Actions
- Shared Image

## Prerequisites

- Azure subscription
- Terraform installed
- Azure CLI installed and authenticated

## Setup

1. Clone this repository
2. Initialize Terraform:
   ```
   terraform init
   ```
3. Review and apply the Terraform configuration:
   ```
   terraform plan
   terraform apply
   ```

## Resources Created

- Azure AD Application: "GitHub Actions - packer-azure-actions"
- Azure AD Service Principal
- Azure Resource Group: "packer-demo"
- Azure Shared Image Gallery: "packer_demo_gallery"
- Role Assignment: Contributor role for the Service Principal
- Federated Identity Credential for GitHub Actions

## Outputs

After applying the Terraform configuration, you'll receive the following outputs:

- `client_id`: The Client ID of the created Service Principal
- `tenant_id`: The Tenant ID of your Azure subscription
- `subscription_id`: The Subscription ID of your Azure subscription

Use these values to configure your GitHub Actions workflow for authentication. Example project: https://github.com/davidgarc/packer-azure-actions

## GitHub Actions Integration

This setup uses OpenID Connect (OIDC) for secure, passwordless authentication between GitHub Actions and Azure. The federated identity credential is configured for the repository "davidgarc/packer-azure-actions" and the "Prod" environment.

## Next Steps

1. Configure your GitHub Actions workflow to use the created Azure resources.
2. Implement your Packer templates for building VM images.
3. Set up your GitHub Actions workflow to trigger Packer builds and manage images in the Shared Image Gallery.

## Contributing

Contributions to this project are welcome. Please fork the repository and submit a pull request with your changes.

## License

[MIT License](LICENSE)
