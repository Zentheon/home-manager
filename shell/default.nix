#
# Shell personalizations
#
{ pkgs, ... }:
{
  # sessionVariables only work if home-manager is configured to manage your shell
  home.sessionVariables = {
    EDITOR = "zeditor";
    GIT_EDITOR = "zeditor";

    # I used to use Kate. It needs a couple extra flags to work:
    # "kate --startanon --block"
  };

  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      eval "$(direnv hook fish)"
    '';

    shellAbbrs = {
      # Some nice nix-related shortcuts:
      # 95% usecase command that builds and switches into a system derivation
      nixup = "sudo nixos-rebuild switch --flake /persist/etc/nixos";
      # Builds the system derivation and sets it as the default boot option
      nixup-boot = "sudo nixos-rebuild boot --flake /persist/etc/nixos";
      # Builds the system derivation but doesn't apply it
      nixup-build = "sudo nixos-rebuild build --flake /persist/etc/nixos";
      # Builds a system derivation without making any changes
      nixup-dry = "nixos-rebuild dry-build --flake /persist/etc/nixos";
      # Updates the system flake
      flakeup = "nix flake update --flake /persist/etc/nixos";

      # home-manager versions
      homeup = "home-manager switch";
      homeup-build = "home-manager build";
    };

    functions = {
      # pretty sure this doesn't work
      nixeval = "nix-instantiate '<nixpkgs/nixos>' -A system";

      # Replacement interactive fish greeting
      fish_greeting = ''
        # Show some fancy system stats, but only when it isn't clutter
        if test (set -q ZED_TERM && echo $ZED_TERM || echo false) != true
          fastfetch
        end
      '';
    };
  };

  # The shell to use (zsh)
  programs.zsh = {
    enable = false;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    # Setup universal shell aliases.
    # TODO: Add a working storepath lookup command (may require a script)
    shellAliases = {
      # Some nice nix-related shortcuts:
      # 95% usecase command that builds and switches into a system derivation
      nixup = "sudo nixos-rebuild switch --flake /persist/etc/nixos";
      # Builds the system derivation and sets it as the default boot option
      nixup-boot = "sudo nixos-rebuild build --flake /persist/etc/nixos";
      # Builds the system derivation but doesn't apply it
      nixup-build = "sudo nixos-rebuild build --flake /persist/etc/nixos";
      # Builds a system derivation without making any changes
      nixup-dry = "nixos-rebuild dry-build --flake /persist/etc/nixos";
      # Updates the system flake
      flakeup = "nix flake update --flake /persist/etc/nixos";
      # pretty sure this doesn't work
      nixeval = "nix-instantiate '<nixpkgs/nixos>' -A system";

      # home-manager versions
      homeup = "home-manager switch";
      homeup-build = "home-manager build";
    };

    initContent = ''
      # Setup ctrl arrow navigation functionality
      bindkey "^[[1;5D" backward-word
      bindkey "^[[1;5C" forward-word
      bindkey "^H" backward-kill-word

      # Setup plugins
      source ${pkgs.zsh-nix-shell}/share/zsh-nix-shell/nix-shell.plugin.zsh
      source ${pkgs.zsh-history-substring-search}/share/zsh-history-substring-search/zsh-history-substring-search.zsh
      source ${pkgs.zsh-z}/share/zsh-z/zsh-z.plugin.zsh

      eval "$(direnv hook zsh)"

      # Kate detaches itself by default, which causes issues with `git commit` for example.
      # `--block` halts the shell until closed, solving that.
      export EDITOR="kate --startanon --block"
      export GIT_EDITOR="kate --startanon --block"

      # Show some fancy system stats, but only when it isn't clutter
      if [[ ''${ZED_TERM: -false} != true ]]; then
        fastfetch
      fi
    '';
  };

  # Fancy terminal prompt
  programs.starship.enable = true;
}
