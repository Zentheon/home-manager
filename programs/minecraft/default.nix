{
  pkgs,
  config,
  mcsr-nixos,
  ...
}:

{
  imports = [ mcsr-nixos.homeManagerModules.waywall ];

  programs.waywall = {
    enable = true;
    config = {
      enableWaywork = true;
      programs = [ mcsr-nixos.packages.x86_64-linux.ninjabrain-bot ];

      files = {
        eye_overlay = ./eye-overlay.png;
      };

      text = ''
        local resolution = { w = 3000, h = 1240 }
      ''
      + builtins.readFile ./waywall.lua;

    };
  };

}
