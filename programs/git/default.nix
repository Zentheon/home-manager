#
#  Git tooling and related functionality
#

{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Zentheon";
        email = "zentheon@mailbox.org";
      };
      init.defaultBranch = "main";
    };
  };
  # GIT_EDITOR is set in shell
}
