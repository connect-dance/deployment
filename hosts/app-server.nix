{ config, options, pkgs, modulesPath, ... }:
{
  imports = [
    "${modulesPath}/installer/scan/not-detected.nix"
    "${modulesPath}/profiles/qemu-guest.nix"
  ];

  disko.devices = import ./disko.nix "/dev/sda";

  boot.loader.grub = {
    devices = [ "/dev/sda" ];
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  services.openssh.enable = true;

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJCDKG7qUInSWAtpgY1AAnKtCk3M8VXyzyetbxDrCsBJ marvin@Theia"
  ];

  networking.useNetworkd = true;
  networking.useDHCP = false;
}
