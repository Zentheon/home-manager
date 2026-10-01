#
# Functionality tied directly to the desktop
#
{ pkgs, config, ... }:
{

  # Hyprland config lsp suggestions
  home.file."${config.xdg.configHome}/hypr/.stubs".source = "${pkgs.hyprland}/share/hypr/stubs";
}
