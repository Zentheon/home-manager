{ ... }:

{
  imports = [
    ./desktop
    ./matugen
    ./programs
    ./xdg
    ./shell
  ];

  home.username = "zentheon";
  home.homeDirectory = "/home/zentheon";

  # Tells home-manager the target version for config backwards compatiblity.
  # Expect outdated configs if bumped
  home.stateVersion = "26.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
