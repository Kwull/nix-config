{ inputs, outputs, pkgs, ... }:

{
  imports =
    [
      inputs.home-manager.nixosModules.home-manager
      ./common-packages.nix
      ./docker.nix
      ./locale.nix
      ./nix.nix
      ./openssh.nix
      ./tailscale.nix
    ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.extraSpecialArgs = {
    inherit inputs outputs;
  };  

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
    };
  };

  networking.domain = "kwull.net";

  users.defaultUserShell = pkgs.zsh;
  environment.shells = [ pkgs.zsh ];

  programs = { 
    zsh.enable = true;
    nix-ld.enable = true;
  };

  security.sudo.wheelNeedsPassword = false;
}
