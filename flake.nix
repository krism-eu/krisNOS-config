{
  description = "Personal krisNOS configuration";

  inputs = {
    krisNOS.url = "github:krism-eu/krisNOS";
    nixpkgs.follows = "krisNOS/nixpkgs";
  };

  outputs =
    {
      self,
      nixpkgs,
      krisNOS,
    }:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      hardwareFile = ./hosts/krisnos/hardware-configuration.nix;
      hasHardware = builtins.pathExists hardwareFile;

      # Before the real hardware file exists, CI still builds the complete
      # personal system with a harmless synthetic root filesystem. This checks
      # the same framework, host policy, services and package set used after install.
      ciSystem = lib.nixosSystem {
        inherit system;
        modules = [
          krisNOS.nixosModules.krisos
          ./hosts/krisnos/configuration.nix
          ({ lib, ... }: {
            fileSystems."/" = {
              device = "/dev/disk/by-label/krisNOS-ci";
              fsType = "btrfs";
            };
            boot.loader.efi.canTouchEfiVariables = lib.mkForce false;
          })
        ];
      };
    in
    {
      # Deliberately expose the real host only after its generated hardware
      # configuration has been reviewed and added to Git.
      nixosConfigurations = lib.optionalAttrs hasHardware {
        krisnos = lib.nixosSystem {
          inherit system;
          modules = [
            krisNOS.nixosModules.krisos
            ./hosts/krisnos/configuration.nix
          ];
        };
      };

      checks.${system} = {
        krisnos-ci-system = ciSystem.config.system.build.toplevel;
      }
      // lib.optionalAttrs hasHardware {
        krisnos-system = self.nixosConfigurations.krisnos.config.system.build.toplevel;
      };

      formatter.${system} = nixpkgs.legacyPackages.${system}.nixfmt;
    };
}
