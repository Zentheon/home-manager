{
  pkgs,
  config,
  ...
}:

{
  programs.kitty = {
    enable = true;
    extraConfig = ''
      include dank-theme.conf
      include dank-tabs.conf

      hide_window_decorations yes
    '';
  };
}
