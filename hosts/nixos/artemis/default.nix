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

  users.defaultUserShell = pkgs.zsh;
  environment.shells = [ pkgs.zsh ];

  programs = { 
    zsh.enable = true;
    nix-ld.enable = true;
  };

  environment.systemPackages = with pkgs; [
    curl
    dnsutils
    btop
    htop
    iotop
    coreutils
    ffmpeg
    dig
    e2fsprogs # badblocks
    git
    gptfdisk
    hddtemp
    lm_sensors
    mc
    mergerfs
    ncdu
    nmap
    qemu
    python3
    smartmontools
    tmux
    mosh
    screen
    tree
    wget
    xfsprogs
    iperf3
    nerdfonts
    unzip
    bash
    zsh-autosuggestions
    zsh-syntax-highlighting
  ];  

}