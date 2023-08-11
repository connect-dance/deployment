# Connect.Dance Deployments

## Terraform

[Terraform Cloud Project](https://app.terraform.io/app/Connect-Dance/workspaces/deployment)

To deploy the servers and all other infrastructure we use Terraform.

## NixOS

We are doing the initial bootstrap of the servers with [nixos-anywhere](https://github.com/numtide/nixos-anywhere).
Afterwards we are using [deploy-rs](https://github.com/serokell/deploy-rs) to deploy the NixOS configs.
