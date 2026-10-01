{
  pkgs,
  ...
}:

let
  alamPlugins = fetchTree {
    type = "git";
    url = "https://github.com/AminurAlam/yazi-plugins";
    rev = "9997d5ba641314a83ed225a73c0293bd013e1bfc";
  };
in
{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    enableFishIntegration = true;

    plugins = {
      fchar = {
        package = "${alamPlugins}/fchar.yazi";
        setup = true;
        settings = {
          # if true: f -> file, File, FILE
          insensitive = true;
          # if true: f -> file, .file, @file, #file, ...file
          skip_symbols = true;
          # if {"yazi-"}: f -> file, yazi-file
          skip_prefix = { };
          aliases = { };
          keys = {
            start = "<C-i>"; # ff -> file
            ext = "e"; # ef -> name.fs
            word = "I"; # Ff -> file, also-file
            all = "<C-I>"; # ^ff -> file, also-file, twofile, elf
          };
        };
      };
      ouch = {
        package = pkgs.yaziPlugins.ouch;
      };
    };

    keymap = {
      mgr.prepend_keymap = [
        {
          on = [ "<C-i>" ];
          run = "plugin fchar";
          desc = "Jump to char";
        }
      ];
    };
  };
}
