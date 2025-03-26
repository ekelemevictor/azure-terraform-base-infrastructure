# Terraform Base Infrastructure: Azure Hub-and-Spoke

This repository contains a **production-ready** template for provisioning a **Hub-and-Spoke** network topology on Microsoft Azure using **Terraform**. It provides environment-specific configurations for multiple subscriptions (Admin, Dev, Staging, Production) and uses Azure Blob Storage for remote state management.

## Table of Contents

1. [Overview](#overview)
2. [Architecture Highlights](#architecture-highlights)
3. [Repository Structure](#repository-structure)
4. [Prerequisites](#prerequisites)
5. [Setup Instructions](#setup-instructions)
6. [Usage](#usage)
7. [Next Steps](#next-steps)
8. [Contributing](#contributing)
9. [References](#references)
---

## Overview

Building a **Hub-and-Spoke** topology allows you to:

- Centralize shared services (DNS, Key Vault, security appliances) in a **Hub** subscription.
- Isolate application environments (Dev, Staging, Production) in **Spoke** subscriptions.
- Enforce consistent **governance** and **network security** across multiple Azure subscriptions.
- Scale and extend the infrastructure easily with Terraform’s modular approach.

## Architecture Highlights

- **Hub Network**: Deployed in an **Admin (Hub) subscription** to host shared services (firewalls, bastion, DNS, etc.).
- **Spoke Networks**: Deployed in **Dev, Staging, and Prod subscriptions** for isolated workloads.
- **Bi-Directional VNet Peering**: Hub ↔ Spoke connectivity for secure resource sharing.
- **Remote State**: Uses Azure Blob Storage for Terraform state management to support collaboration and CI/CD.

## Repository Structure

A typical layout for this repo might look like this:

```
terraform-base-infrastructure/
├── environments/
│   ├── admin_network/          # The Hub environment (Admin subscription)
│   │   ├── backend.tf
│   │   ├── providers.tf
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── locals.tf
│   │   └── terraform.tfvars
│   ├── dev_network/            # Dev Spoke environment
│   ├── staging_network/        # Staging Spoke environment
│   └── prod_network/           # Production Spoke environment
│
├── modules/                    # Reusable Terraform modules
│   ├── hub_network/            # Hub VNet, subnets, etc.
│   └── spoke_network/          # Spoke VNet, subnets, peering logic
│
└── README.md                   # This file
```

- **`environments/*_network/`**: Each environment has its own Terraform code, variables, and backend configuration.
- **`modules/`**: Self-contained modules for the **Hub** and **Spoke** networks, reused across environments.

---

## Prerequisites

1. **Azure Subscriptions**  
   - **Admin (Hub) Subscription**: For central/shared services.  
   - **Dev, Staging, Production Subscriptions**: For each environment or workload.  
   - Sufficient permissions (e.g., Contributor) in each subscription.

2. **Azure CLI**  
   - Install from the [Azure CLI docs](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli).  
   - Run `az login` to authenticate.

3. **Terraform**  
   - Install the [latest Terraform](https://developer.hashicorp.com/terraform/downloads) for your OS.  
   - Run `terraform -version` to confirm installation.

4. **Azure Storage Account** (for Remote Backend)  
   - Resource Group (e.g., `terraform-state-rg`)  
   - Storage Account (e.g., `thatsreguytfstatefilesa`)  
   - Blob Container (e.g., `tfstate`)  
   - [**Optional**] Use CLI commands to create these quickly:

     ```bash
     az group create --name terraform-state-rg --location eastus
    ```

    ```bash
     az storage account create \
       --name <unique-storage-account-name> \
       --resource-group terraform-state-rg \
       --location eastus \
       --sku Standard_LRS \
       --encryption-services blob
    ```

    ```bash
     az storage container create \
       --name tfstate \
       --account-name <unique-storage-account-name>
     ```

---

## Setup Instructions

### 1. Clone the Repository

```bash
git clone https://github.com/ekelemevictor/azure-terraform-base-infrastructure.git
cd azure-terraform-base-infrastructure
```

### 2. Review the Environments

Inside `environments/`, you’ll find folders for each environment (`admin_network`, `dev_network`, etc.). Each folder has:

- **`backend.tf`** – Points Terraform to your Azure Storage Account for remote state.  
- **`providers.tf`** – Configures provider aliases (for multi-subscription use).  
- **`main.tf`** – Calls reusable modules from `modules/`.  
- **`variables.tf`** – Declares input variables.  
- **`terraform.tfvars`** – Environment-specific variable values (e.g., `subscription_id`, `location`, `CIDR blocks`).  

> **Important**: Update the values in each environment’s `terraform.tfvars` to match your Azure subscription IDs, resource names, and IP address ranges.

### 3. Configure Remote State (Optional, if you have not done so)

If you haven’t yet created an Azure Storage Account for state, do it now.  
Then, in each environment’s **`backend.tf`** file, set:

```hcl
terraform {
  backend "azurerm" {
    resource_group_name  = "terraform-state-rg"
    storage_account_name = "thatsreguytfstatefilesa"
    container_name       = "tfstate"
    key                  = "admin-network/terraform.tfstate"
  }
}
```

- Change `resource_group_name`, `storage_account_name`, `container_name`, and the `key` path to match your environment.

### 4. Initialize Terraform in Each Environment

Go into each environment folder and run:

```bash
cd environments/admin_network
terraform init
```

> **Tip**: Always run `terraform init` after updating **`backend.tf`** or **`providers.tf`**.

---

## Usage

### Step 1: Plan

To preview changes, run:

```bash
terraform plan -var-file="terraform.tfvars"
```

- Verifies your configuration.
- Shows resources to be created/changed/destroyed.

### Step 2: Apply

If the plan looks correct, provision the resources:

```bash
terraform apply -var-file="terraform.tfvars"
```

- Terraform will prompt for confirmation (type **yes**).
- After completion, your Azure environment should have the new resources.

### Step 3: Repeat for Other Environments

1. **Admin (Hub) Network** – sets up central shared services network.  
2. **Dev, Staging, Production** – sets up each Spoke network, including VNet peering back to the Hub.  

Navigate to each environment folder, update `terraform.tfvars` if needed, then `init`, `plan`, and `apply`.

---

## Next Steps

This base infrastructure is just the beginning. You can extend it by:

- **Integrating Private DNS Zones** for internal name resolution.
- **Adding Key Vault** for secure secrets and certificates.
- **Incorporating NSGs or Firewall** rules for advanced security posture.
- **Automating with CI/CD** pipelines (GitHub Actions, Azure DevOps, etc.) for continuous delivery of infrastructure changes.
- **Monitoring & Logging** (Azure Monitor, Log Analytics) across Hub and Spokes.

---

## Contributing

1. **Fork** the repo and create your feature branch:
   ```bash
   git checkout -b feature/some-new-feature
   ```
2. **Commit** your changes:
   ```bash
   git commit -m "Add some new feature"
   ```
3. **Push** your branch:
   ```bash
   git push origin feature/some-new-feature
   ```
4. **Open a Pull Request** describing your changes.

---
## References

- [Detailed Blog Post on Building Hub-and-Spoke with Terraform](https://www.thatsreguy.com/p/cfc66cec-6880-4121-aebd-0f3a7b378dfe)
- [Terraform Documentation](https://developer.hashicorp.com/terraform)
- [Hub-spoke network topology in Azure](https://learn.microsoft.com/en-us/azure/architecture/networking/architecture/hub-spoke)

---

**Happy Terraforming!** If you have any questions or issues, feel free to open an [issue](../../issues) or reach out via a Pull Request.