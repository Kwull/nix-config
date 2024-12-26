{ inputs, outputs, pkgs, ... }:

{
  imports =
    [
      ./common-packages.nix
      ./docker.nix
      ./locale.nix
      ./nix.nix
      ./openssh.nix
      ./tailscale.nix
    ];
 #   ++ (builtins.attrValues outputs.nixosModules);

  networking.domain = "kwull.net";

  users.defaultUserShell = pkgs.zsh;
  environment.shells = [ pkgs.zsh ];

  programs = { 
    zsh.enable = true;
    nix-ld.enable = true;
  };

  security.sudo.wheelNeedsPassword = false;
}
