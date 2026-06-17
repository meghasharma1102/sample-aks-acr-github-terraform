# sample-aks-acr-github-terraform

GitHub Actions based Terraform deployment for:

- VNet and subnets
- Private AKS
- ACR with private endpoint
- Windows jumpbox VM

This variant is set up to use GitHub OIDC with Azure instead of `AZURE_CREDENTIALS`.

## Required GitHub Secrets

- `AZURE_CLIENT_ID`
- `AZURE_TENANT_ID`
- `AZURE_SUBSCRIPTION_ID`
- `JUMPBOX_ADMIN_PASSWORD`

## Azure Setup

1. Create or use an Azure identity.
2. Add a federated credential for this GitHub repo and branch.
3. Grant the identity the required Azure RBAC permissions.
4. Grant storage access for the Terraform backend account.

## Workflow Behavior

- Push to `main` or `dev`: login, init, validate, plan
- Manual run with `action=apply`: login, init, validate, plan, then apply

## Notes

- Backend state uses storage account `stcaseprojecttfstate` and container `tfstate`.
- The Windows jumpbox password comes from `JUMPBOX_ADMIN_PASSWORD`.
- If OIDC is branch-scoped, make sure the federated credential matches the branch that runs the workflow.
- This workflow is intentionally kept simple: one job for plan, and optional apply in the same run.
- Pull request trigger is removed to avoid OIDC subject mismatch confusion. Push to `dev`, review the plan result, then raise a PR to `main`.
