{
  description = "Connect.Dance Deployments";

  inputs = {
    nixpkgs.url =
      "github:nixos/nixpkgs/nixos-unstable"; # Nix Packages collection
    unstable.url = "github:nixos/nixpkgs";
    utils.url =
      "github:gytis-ivaskevicius/flake-utils-plus"; # Use Nix flakes without any fluff
    nixos-hardware.url =
      "github:NixOS/nixos-hardware"; # A collection of NixOS modules covering hardware quirks.
    agenix = {
      # age-encrypted secrets for NixOS
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{ self
    , nixpkgs
    , utils
    , nixos-hardware
    , agenix
    , disko
    , ...
    }:
    utils.lib.mkFlake {
      inherit self;

      inputs = nixpkgs.lib.filterAttrs (n: _: n != "agenix") inputs;

      supportedSystems = [ "x86_64-linux" ];
      channelsConfig.allowUnfree = true;

      hosts = {
      };

      outputsBuilder = channels: {
        devShells = {
          default = channels.nixpkgs.mkShell {
            name = "deplyments-shell";
            packages = with channels.nixpkgs; [
              nix
              terraform
            ];
          };
        };
      };
    };
}
