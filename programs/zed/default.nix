{ pkgs, zed-extensions, ... }:

{

  nixpkgs.overlays = [
    zed-extensions.overlays.default
  ];

  imports = [ zed-extensions.homeManagerModules.default ];

  programs = {
    zed-editor = {
      enable = true;
      package = pkgs.zed-editor-fhs;
    };
    zed-editor-extensions = {
      enable = true;
      packages = with pkgs.zed-extensions; [
        discord-presence
        nix
        toml
        lua
        git-firefly
        catppuccin
        catppuccin-icons
      ];
    };
  };
}
