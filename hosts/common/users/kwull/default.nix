{ pkgs, config, lib, ...}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  users.mutableUsers = false;
  users.users.kwull = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = ifTheyExist [
      "audio"
      "docker"
      "git"
      "i2c"
      "libvirtd"
      "lxd"
      "network"
      "plugdev"
      "podman"
      "video"
      "wheel"
      "wireshark"
    ];

    openssh.authorizedKeys.keys = lib.splitString "\n" (builtins.readFile ../../../../home/kwull/ssh.pub);
    #hashedPasswordFile = config.sops.secrets.kwull-password.path;
    #packages = [pkgs.home-manager];
  };

  #sops.secrets.kwull-password = {
  #  sopsFile = ../../secrets.yaml;
  #  neededForUsers = true;
  #};

  h#ome-manager.users.kwull = import ../../../../home/kwull/${config.networking.hostName}.nix;

  security.pam.services = {
    swaylock = {};
  };
}