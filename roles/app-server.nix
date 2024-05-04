{
  modulesPath,
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./base.nix
  ];

  services.caddy = {
    enable = true;
    virtualHosts."connect.dance" = {
      extraConfig = ''
        encode gzip
        file_server
        root * ${
          pkgs.runCommand "testdir" {} ''
            mkdir "$out"
            echo hello world > "$out/index.html"
          ''
        }
      '';
    };
    virtualHosts."www.connect.dance" = {
      extraConfig = ''
        redir https://connect.dance{uri}
      '';
    };
  };

  networking.firewall.allowedTCPPorts = [80 443];
}
