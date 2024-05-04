{
  description = "Connect.Dance Deployments";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; # Nix Packages collection
    flake-parts.url = "github:hercules-ci/flake-parts";
    agenix = {
      # age-encrypted secrets for NixOS
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-anywhere.url = "github:nix-community/nixos-anywhere";
    deploy-rs.url = "github:serokell/deploy-rs";
  };

  outputs = inputs @ {flake-parts, ...}:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux" "aarch64-linux"];

      perSystem = {
        config,
        self',
        inputs',
        pkgs,
        system,
        lib,
        ...
      }: {
        devShells = {
          default = pkgs.mkShell {
            packages = [
              pkgs.opentofu
              pkgs.sops
              inputs'.nixos-anywhere.packages.default
              inputs'.deploy-rs.packages.default
              inputs'.agenix.packages.default
            ];
          };
        };
      };

      flake = {
        nixosConfigurations.appServer = inputs.nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          modules = [
            inputs.disko.nixosModules.disko
            ./roles/app-server.nix
          ];
        };
        deploy.nodes.appServer.profiles.system = {
          hostname = "connect.dance";
          user = "root";
          path = inputs.deploy-rs.lib.x86_64-linux.activate.nixos inputs.self.nixosConfigurations.appServer;
        };
      };
    };
}
