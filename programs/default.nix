#
# My programs!
#
# Small things could be put in this file, but anything with an "enables" I prefer to keep in a
# separate module. Libraries and utils and stuff typically make more sense to be system-wide.
#
{
  imports = [
    ./git/default.nix
    ./kitty/default.nix
    ./minecraft/default.nix
    ./yazi/default.nix
    ./zed/default.nix
  ];

  home.packages = [
    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];
}
