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

  boot.loader.systemd-boot.configurationLimit = 5;
  zramSwap.memoryPercent = 25;
  time.timeZone = "Europe/Rome";
}
