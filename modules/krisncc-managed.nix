# THIS FILE IS OWNED BY krisNCC.
#
# krisNCC may change only this file, only after showing a diff and after an
# explicit user action. Hand-written Nix belongs in free.nix or local-system.nix.
{ ... }:
{
  # Curated structural settings: useful to change from the GUI, but not daily
  # runtime state. Values here intentionally override krisNOS framework defaults.
  krisos.autoLogin = true;
  krisos.bluetoothPowerOnBoot = false;

  krisos.bootEntryLimit = 5;

  # System packages explicitly managed by krisNCC.
  # Persistent global permission: removing an unfree system package does
  # not revoke this setting automatically.
  krisos.allowUnfreeSystemPackages = false;
  krisos.extraSystemPackages = [
    # krisNCC system packages: begin
    # krisNCC system packages: end
  ];
  zramSwap.memoryPercent = 25;
  time.timeZone = "Europe/Rome";
}
