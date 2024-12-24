{ config, lib, pkgs, ... }:
{
  imports = [ ./hardware-configuration.nix ];
  system.stateVersion = "24.11";

  nix.settings = { 
    auto-optimise-store = true;
    experimental-features = [ "nix-command" "flakes" ];
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernel.sysctl."net.ipv4.ip_forward" = 1;

  time.timeZone = "Europe/Warsaw";

  users.users.kwull = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ];
    shell = pkgs.zsh;
    hashedPassword = "${HASHED_PASSWORD}";
    #packages = with pkgs; [];
  };

  security.sudo.wheelNeedsPassword = false;
  users.defaultUserShell = pkgs.zsh;
  environment.shells = [ pkgs.zsh ];

  programs.bash.enable = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
  };

  programs.git = {
    enable = true;
    userEmail = "kwull@kwull.com";
    userName = "Uladzimir Kazakevich";
    diff-so-fancy.enable = true;
    lfs.enable = true;
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
      pull = {
        rebase = true;
      };
    };
  };

  programs.htop = {
    enable = true;
    settings.show_program_path = true;
  };

  programs.tmux = {
    enable = true;
    clock24 = true;
    historyLimit = 10000;
  };

  environment.systemPackages = with pkgs; [
    net-tools
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
    python-setuptools
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
  ];  

  networking = {
    firewall.enable = false;
    hostName = "artemis";
  };

  virtualisation = {
    docker = {
      enable = true;
      autoPrune = {
        enable = true;
        dates = "weekly";
      };
    };
  };

  services.openssh.enable = true;
  services.qemuGuest.enable = true;
}