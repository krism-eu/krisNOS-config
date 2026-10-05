{ config, lib, ... }:
let
  hardwareFile = ./hardware-configuration.nix;
in
{
  imports = [
    ../../modules/local-system.nix
  ] ++ lib.optional (builtins.pathExists hardwareFile) hardwareFile;

  krisos = {
    userName = "kris";
    hostName = "krisnos";
    autoLogin = true;
    bluetoothPowerOnBoot = false;
    flatpak = true;
    distrobox = true;
    mutableRuntime = true;
    bootEntryLimit = 5;
  };

  users.users.${config.krisos.userName} = {
    isNormalUser = true;
    description = "krisNOS user";
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
      "render"
      "audio"
      "lp"
    ];

    # Rootless Podman is an implementation detail used by Distrobox.
    subUidRanges = [ { startUid = 100000; count = 65536; } ];
    subGidRanges = [ { startGid = 100000; count = 65536; } ];
  };

  # Credentials remain local/mutable and are never stored in this repository.
  users.mutableUsers = true;

  # Installation compatibility baseline. Do not bump merely because nixpkgs
  # advances; change only when intentionally migrating NixOS state semantics.
  system.stateVersion = "26.05";
}
