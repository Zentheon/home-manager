{
  pkgs,
  config,
  ...
}:

let
  defaultBrowser = "zen-beta.desktop";
in
{
  # Sets up stuff for yazi as the file picker
  # home.file."$XDG_CONFIG_HOME/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh".source =
  #   "${pkgs.xdg-desktop-portal-termfilechooser}/share/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh";

  # # Building this configuration will create a copy of 'dotfiles/screenrc' in
  # # the Nix store. Activating the configuration will then make '~/.screenrc' a
  # # symlink to the Nix store copy.
  # ".screenrc".source = dotfiles/screenrc;
  home.file."${config.xdg.configHome}/xdg-desktop-portal-termfilechooser/config".text = ''
    [filechooser]
    cmd=yazi-wrapper.sh
    create_help_file=0
    default_dir=$HOME
    env=TERMCMD=foot
         EDITOR=nvim
    open_mode=suggested
    save_mode=last
  '';

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
    xdgOpenUsePortal = true;
    config = {
      hyprland = {
        default = [
          "hyprland;gtk"
        ];
        "org.freedesktop.impl.portal.Secret" = [
          "none" # Use keepass secret service
        ];
        "org.freedesktop.impl.portal.FileChooser" = [
          "termfilechooser"
        ];
        "org.freedesktop.impl.portal.RemoteDesktop" = [
          "kde"
        ];
      };
    };
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "application/x-extension-htm" = [ defaultBrowser ];
      "application/x-extension-html" = [ defaultBrowser ];
      "application/x-extension-shtml" = [ defaultBrowser ];
      "application/x-extension-xht" = [ defaultBrowser ];
      "application/x-extension-xhtml" = [ defaultBrowser ];

      "inode/directory" = [
        "yazi.desktop"
      ];
      "x-scheme-handle/file" = [
        "yazi.desktop"
      ];
      "x-scheme-handler/http" = [ defaultBrowser ];
      "x-scheme-handler/https" = [ defaultBrowser ];
    };
    defaultApplicationPackages = [

    ];
  };
  xdg.terminal-exec = {
    enable = true;
    settings = {
      default = [
        "kitty.desktop"
      ];
    };
  };
}
