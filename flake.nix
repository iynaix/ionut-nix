{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    prismlauncher = {
      url = "github:fn2006/PollyMC";
      # Optional: Override the nixpkgs input of prismlauncher to use the same revision as the rest of your flake
      # Note that overriding any input of prismlauncher may break reproducibility
      # inputs.nixpkgs.follows = "nixpkgs";
    };
  };
outputs = inputs@{nixpkgs, prismlauncher, ...}: {
    nixosConfigurations.foo = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };

      modules = [
        ({pkgs, ...}: {
          environment.systemPackages = [inputs.pollymc.overlays.default ];
        })
      ];
    };
  };
}
