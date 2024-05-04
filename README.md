# Connect.Dance Deployments

## Datacenter

Hosted on Hetzner
- https://console.hetzner.cloud/projects

## Terraform

[Terraform Cloud Project](https://app.terraform.io/app/Connect-Dance/workspaces/deployment)

To deploy the servers and all other infrastructure we use Terraform.

## NixOS

We are doing the initial bootstrap of the servers with [nixos-anywhere](https://github.com/numtide/nixos-anywhere).
Afterwards we are using [deploy-rs](https://github.com/serokell/deploy-rs) to deploy the NixOS configs.

## Secrets

The deployment secrets are encrypted with SOPS.
I followed [this guide](https://devops.datenkollektiv.de/using-sops-with-age-and-git-like-a-pro.html).

## TODO

- https://nixos.wiki/wiki/Install_NixOS_on_Hetzner_Cloud#Network_configuration
- https://flakm.com/posts/nixos_rust/03_deployment/
- Setup NetBird VPN
