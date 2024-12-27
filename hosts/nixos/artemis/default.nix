{ pkgs, ... }:
{
  imports = [ 
    ./hardware-configuration.nix 
    ./../../common/global
    ./../../common/users/kwull
    ./../../common/optional/systemd-boot.nix
  #  ./../../common/optional/tailscale-exit-node.nix
  ];

  services.qemuGuest.enable = true;
  boot.kernel.sysctl."net.ipv4.ip_forward" = 1;
  # services.tailscale.useRoutingFeatures = "server";

  networking = {
    firewall.enable = false;
    hostName = "artemis";
  };

  system.stateVersion = "24.11";
}