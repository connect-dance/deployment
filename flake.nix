{
  description = "Connect.Dance Deployments";

  inputs = {
    nixpkgs.url =
      "github:nixos/nixpkgs/nixos-unstable"; # Nix Packages collection
    utils.url =
      "github:gytis-ivaskevicius/flake-utils-plus"; # Use Nix flakes without any fluff
    agenix = {
      # age-encrypted secrets for NixOS
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ self
    , nixpkgs
    , utils
    , agenix
    , disko
    , ...
    }:
    utils.lib.mkFlake {
      inherit self;

      inputs = nixpkgs.lib.filterAttrs (n: _: n != "agenix") inputs;

      supportedSystems = [ "x86_64-linux" "aarch64-linux" ];
      channelsConfig.allowUnfree = true;

      hosts = {
        appServer = {
          system = "aarch64-linux";
          modules = [
            disko.nixosModules.disko
            ./hosts/app-server.nix
          ];
        };
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
