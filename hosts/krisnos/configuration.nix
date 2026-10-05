{ config, lib, ... }:
let
  hardwareFile = ./hardware-configuration.nix;
in
{
  imports = [
    ../../modules/local-system.nix
    ../../modules/krisncc-managed.nix
    ../../modules/free.nix
  ] ++ lib.optional (builtins.pathExists hardwareFile) hardwareFile;

  # Machine identity and framework choices stay human-owned here.
  krisos = {
    userName = "kris";
    hostName = "krisnos";
    flatpak = true;
    distrobox = true;
    mutableRuntime = true;
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

    # Rootless Podman is only the engine used by Distrobox.
    subUidRanges = [ { startUid = 100000; count = 65536; } ];
    subGidRanges = [ { startGid = 100000; count = 65536; } ];
  };

  # Credentials remain local/mutable and are never stored in this repository.
  users.mutableUsers = true;

  # Installation compatibility baseline. Do not bump merely because nixpkgs
  # advances; change only when intentionally migrating NixOS state semantics.
  system.stateVersion = "26.05";
}
