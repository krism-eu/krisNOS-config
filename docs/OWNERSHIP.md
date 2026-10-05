# Ownership boundary

## krisNOS owns

- reusable NixOS modules and safe framework defaults;
- core/base integration;
- helper programs;
- krisNCC source and packaging;
- ISO/installer/build infrastructure.

Framework values that are intended to be personalized should use NixOS defaults (`lib.mkDefault`) rather than fighting the personal configuration.

## krisNOS-config owns

- host identity and machine-specific configuration;
- generated `hardware-configuration.nix`;
- intentional personal NixOS overrides;
- safe/exportable krisNCC preferences.

Within this repository the ownership is split further:

- `modules/krisncc-managed.nix`: curated structural values that krisNCC may rewrite after showing a diff;
- `modules/local-system.nix`: human-owned structural overrides;
- `modules/free.nix`: arbitrary personal Nix, never rewritten by krisNCC;
- `hosts/krisnos/hardware-configuration.nix`: generated hardware facts, never rewritten by krisNCC.

## Native mutable backends own

- NetworkManager connections, Wi-Fi, VPN and DNS state;
- BlueZ devices/radio state;
- PipeWire/WirePlumber routing and session state;
- CUPS printers/queues;
- firewalld zones/rules/runtime configuration;
- power profile state;
- Flatpak applications;
- Distrobox environments;
- KDE/user configuration.

Do not mirror native runtime databases into Git merely to make them declarative. GitHub sync is optional and manual; syncing configuration never means applying it.
