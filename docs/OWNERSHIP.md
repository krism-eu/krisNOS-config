# Ownership boundary

## krisNOS owns

- reusable NixOS modules;
- core/base integration;
- helper programs;
- krisNCC source and packaging;
- ISO/installer/build infrastructure.

## krisNOS-config owns

- host identity and machine-specific configuration;
- generated `hardware-configuration.nix`;
- intentional personal NixOS overrides;
- safe/exportable krisNCC preferences.

## Native mutable backends own

- NetworkManager connections and VPN runtime state;
- BlueZ devices/radio state;
- PipeWire/WirePlumber routing and session state;
- CUPS printers/queues;
- firewalld zones/rules/runtime configuration;
- Flatpak applications;
- Distrobox containers;
- KDE/user configuration.

Do not mirror native runtime databases into Git merely to make them "declarative".
