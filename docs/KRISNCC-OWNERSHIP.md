# krisNCC configuration ownership

The configuration deliberately separates GUI-managed Nix from free-form Nix.

```text
modules/
├── krisncc-managed.nix  # krisNCC may regenerate this file
├── local-system.nix     # human-owned structural overrides
└── free.nix             # human-owned arbitrary Nix
```

Rules:

- krisNCC never parses and rewrites `free.nix` or `local-system.nix`;
- before writing `krisncc-managed.nix`, krisNCC must show the generated Nix and a diff;
- external changes to `krisncc-managed.nix` invalidate an in-memory edit session and require reload;
- save, Git sync, Nix validation/build and NixOS activation remain distinct actions;
- day-to-day NetworkManager/BlueZ/PipeWire/CUPS/firewalld/Distrobox/Flatpak state stays outside these files and uses native mutable backends;
- secrets and runtime databases are never exported into this public repository.

This provides the useful property of NiCo's free-form Nix blocks without relying on marker comments inside a regenerated file.
