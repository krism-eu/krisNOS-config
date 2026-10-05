{ config, lib, ... }:
let
  hardwareFile = ./hardware-configuration.nix;
in
{
  imports = [
    ../../modules/local-system.nix
    ../../modules/krisncc-managed.nix
    ../../modules/free.nix
  ]
  ++ lib.optional (builtins.pathExists hardwareFile) hardwareFile;

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
    # Initial Fedora-like convenience policy: local login/autologin without a
    # password. With mutableUsers=true a later `passwd kris` change is kept.
    initialHashedPassword = "";
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
      "render"
      "audio"
      "lp"
    ];

    # Rootless Podman is only the engine used by Distrobox.
    subUidRanges = [
      {
        startUid = 100000;
        count = 65536;
      }
    ];
    subGidRanges = [
      {
        startGid = 100000;
        count = 65536;
      }
    ];
  };

  # Credentials remain local/mutable and are never stored in this repository.
  users.mutableUsers = true;

  # Initial personal-host policy: `kris` is an administrator without sudo
  # password prompts. Root keeps a separate password set locally at install.
  security.sudo.enable = true;
  security.sudo.wheelNeedsPassword = false;

  # Installation compatibility baseline. Do not bump merely because nixpkgs
  # advances; change only when intentionally migrating NixOS state semantics.
  system.stateVersion = "26.05";
}
