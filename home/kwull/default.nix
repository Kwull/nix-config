{ config, inputs, pkgs, lib, unstablePkgs, ... }:
{
  # list of programs
  # https://mipmip.github.io/home-manager-option-search

  programs.home-manager.enable = true;
  programs.nix-index.enable = true;

  home = {
    username = lib.mkDefault "kwull";
    homeDirectory = lib.mkDefault "/home/kwull";
    stateVersion = lib.mkDefault "24.11";
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
      merge = {
        conflictStyle = "diff3";
      };
      pull.rebase = true;
    };
  };

  programs.htop = {
    enable = true;
    settings.show_program_path = true;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    #initExtra = (builtins.readFile ../mac-dot-zshrc);
  };

  programs.tmux = {
    enable = true;
    clock24 = true;
    historyLimit = 10000;
  };

  
}