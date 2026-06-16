# sample-aks-acr-github-terraform

This folder is the GitHub-based variant of `sample-aks-acr-terraform`.

The production stack is configured to use an existing resource group through a Terraform data source instead of creating a new one.

It provisions the same Azure infrastructure with Terraform:

- Virtual network and subnets
- Private AKS cluster
- Azure Container Registry
- Windows jumpbox VM

