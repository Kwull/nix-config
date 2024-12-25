{ config, lib, pkgs, modulesPath, ... }:
{
  imports = [ 
    ./hardware-configuration.nix 
    ./../../common/nixos-config.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernel.sysctl."net.ipv4.ip_forward" = 1;

  users.users.kwull = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG9Dlv5MQQNdpzpgYjZww1/L5k9fVVVIR7kTB2q/lS/J kwull"
    ];
  };

  networking = {
    firewall.enable = false;
    hostName = "artemis";
  };

  security.sudo.wheelNeedsPassword = false;
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

  services.openssh.enable = true;
  services.qemuGuest.enable = true;
  # services.tailscale.useRoutingFeatures = "server";
}