{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    sops-nix.url = "github:mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, sops-nix, ... }:
  let
    system = "x86_64-linux";

    mkHost = name: nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        sops-nix.nixosModules.sops
        ./nixos/configuration.nix
        ./hosts/${name}/configuration.nix
      ];
    };
  in {
    nixosConfigurations = {
      butterfly = mkHost "butterfly";
      vm = mkHost "vm";
    };
  };
}
