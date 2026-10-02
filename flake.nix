{
  description = "Home Manager configuration of zentheon";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    matugen = {
      # Material You base16 theming
      url = "github:/InioX/Matugen";
    };

    zed-extensions = {
      url = "github:DuskSystems/nix-zed-extensions";
    };

    # Extra packages that let the MCSR mods work on nixos
    mcsr-nixos = {
      url = "https://git.uku3lig.net/uku/mcsr-nixos/archive/main.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs =
    {
      nixpkgs,
      home-manager,
      matugen,
      zed-extensions,
      mcsr-nixos,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      homeConfigurations."zentheon" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Pass individual inputs through to modules via extraSpecialArgs
        extraSpecialArgs = {
          inherit matugen zed-extensions mcsr-nixos;
        };

        # The Config:tm:
        modules = [
          ./home.nix
        ];
      };
    };
}
