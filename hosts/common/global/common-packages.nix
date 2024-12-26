{ inputs, pkgs, unstablePkgs, ... }:
let
  inherit (inputs) nixpkgs nixpkgs-unstable;
in
{
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    curl
    dnsutils
    btop
    htop
    iotop
    coreutils
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
    ffmpeg
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