{
  pkgs,
  mcsr-nixos,
  ...
}:
let
  mcsrPkgs = mcsr-nixos.packages.${pkgs.stdenv.hostPlatform.system};

  thin = pkgs.fetchurl {
    url = "https://v.uku.moe/u/thin.png";
    hash = "sha256-VzT9a0/+JMG+To80+xuQSo4x2w6+zavCvUJ6irBkpVg=";
  };

  wide = pkgs.fetchurl {
    url = "https://v.uku.moe/u/wide.png";
    hash = "sha256-xJX+QladHQiQYBdKZEB9kuEaxBWVZuuStf4r4gIv5uo=";
  };

  tall = pkgs.fetchurl {
    url = "https://v.uku.moe/u/tall.png";
    hash = "sha256-RLyV6iFVDlJKKEdA3CBAQR/sIj2WnhZVBAmLzVmS7JA=";
  };
in
{
  imports = [ mcsr-nixos.nixosModules.waywall ];

  environment.systemPackages = with pkgs; [
    (prismlauncher.override {
      additionalLibs = [
        jemalloc
        libxtst
        libxkbcommon
        libxt
        libxinerama
      ];
    })
  ];

  programs.waywall = {
    enable = true;
    config = {
      enableWaywork = true;
      programs = [ mcsrPkgs.ninjabrain-bot ];
      files = {
        eye_overlay = ./eye-overlay.png;
        inherit thin wide tall;
      };

      source = ./waywall.lua;

      linkWithSystemd = false;
    };
  };

}
