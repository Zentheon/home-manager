[home-manager](https://github.com/nix-community/home-manager) configs!

There are a few ways to pair NixOS and Home Manager. I prefer the standalone method for one very simple reason: Build go (fairly) fast. Ofc, it also makes way more sense from a practicality perspective, but like, it mostly comes down to build time.

I already have an impermanence with ZFS setup working nicely for the system. The next big thing is doing that for my home dir.

Stuff like production apps, games, personalization and all that stuff would go here, whereas utilities and creating a functional system are for the NixOS side. As an example: DankMaterialShell(dms) itself is installed system-wide, but plugins should be user-side (though this isn't exactly the case here yet...)

## Todo

- Move more programs out of system config that should maybe be here instead
  - Millennium(steam) has been giving me issues. Gotta look at that again when i move it here
- Pin the entire system to a single nixpkgs
- Rely a little less on DMS matugen templates
- Make qt and gtk configs not suck
- Setup user-level impermanence; centralize important stuff and back it up
- *maybe* move hyprland configs to `./desktop`? nonstandard paths might be jank
- Figure out a more concrete general "spec" to follow than just basing off vibes
