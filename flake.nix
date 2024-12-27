{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    #home-manager.url = "github:nix-community/home-manager/release-24.11";
    #home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, ... }@inputs:
    let
      inherit (self) outputs;
      pkgsLinux = import nixpkgs { system = "x86_64-linux"; };
      pkgsLinuxUnstable = import nixpkgs-unstable { system = "x86_64-linux"; };
    in
    {
      nixosConfigurations.artemis = nixpkgs.lib.nixosSystem {
        # NOTE: Change this to aarch64-linux if you are on ARM
        system = "x86_64-linux";
        modules = [ ./hosts/nixos/artemis ];
      };
    };
}
