{
  description = "Personal krisNOS configuration";

  inputs = {
    krisNOS.url = "github:krism-eu/krisNOS";
    nixpkgs.follows = "krisNOS/nixpkgs";
  };

  outputs = { self, nixpkgs, krisNOS }:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      hardwareFile = ./hosts/krisnos/hardware-configuration.nix;
      hasHardware = builtins.pathExists hardwareFile;
    in {
      # Deliberately expose the real host only after its generated hardware
      # configuration has been reviewed and added to Git.
      nixosConfigurations = lib.optionalAttrs hasHardware {
        krisnos = lib.nixosSystem {
          inherit system;
          specialArgs = { inherit self krisNOS; };
          modules = [
            krisNOS.nixosModules.krisos
            ./hosts/krisnos/configuration.nix
          ];
        };
      };

      checks.${system} = lib.optionalAttrs hasHardware {
        krisnos-system = self.nixosConfigurations.krisnos.config.system.build.toplevel;
      };

      formatter.${system} = nixpkgs.legacyPackages.${system}.nixfmt-rfc-style;
    };
}
