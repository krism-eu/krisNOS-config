{ ... }:
{
  # Personal *structural* NixOS overrides belong here when they genuinely need
  # a rebuild. Day-to-day state (NetworkManager, BlueZ, PipeWire, CUPS,
  # firewalld, Distrobox, Flatpak, KDE settings) must stay in its native mutable
  # backend and should not be duplicated declaratively here.
}
