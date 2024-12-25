{
  config,
  pkgs,
  name,
  ...
}:

{
  time.timeZone = "Europe/Warsaw";
  system.stateVersion = "24.11";

  services.openssh.enable = true;
  services.tailscale.enable = true;

  virtualisation = {
    docker = {
      enable = true;
      autoPrune = {
        enable = true;
        dates = "weekly";
      };
    };
  };

  nix = {
    settings = {
        experimental-features = [ "nix-command" "flakes" ];
        warn-dirty = false;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 5";
    };
  };

  ## DEPLOYMENT
  #deployment.targetHost = name;
  deployment = {
    targetUser = "root";
    buildOnTarget = true;
  };
}