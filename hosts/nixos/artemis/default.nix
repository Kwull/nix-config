{ config, lib, pkgs, modulesPath, ... }:
{
  imports = [ 
    ./hardware-configuration.nix 
    ./../../common/global
    ./../../common/users/kwull
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  services.qemuGuest.enable = true;

  boot.kernel.sysctl."net.ipv4.ip_forward" = 1;
  # services.tailscale.useRoutingFeatures = "server";

  networking = {
    firewall.enable = false;
    hostName = "artemis";
  };

  system.stateVersion = "24.11";
}