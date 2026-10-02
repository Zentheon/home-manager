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
  blenderPreview = fetchTree {
    type = "git";
    url = "https://github.com/walldmtd/blender-preview.yazi";
    rev = "5d824cbbfb395864051a6143c077f5e20a0bb06c";
  };
in
{
  programs.yazi = {
    enable = true;
    enableFishIntegration = true;

    # yazi plugins (and their configs)
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
      spot = {
        package = "${alamPlugins}/spot.yazi";
        setup = true;
        settings = {
          metadata_section = {
            enable = true;
            hash_cmd = "sha256sum";
            hash_filesize_limit = 1000; # in MB, set 0 to disable
            relative_time = true; # 2026-01-01 or n days ago
            time_format = "%Y-%m-%d %H:%M"; # https://www.man7.org/linux/man-pages/man3/strftime.3.html
            show_compression = true;
          };
        };
      };
      zoom = {
        package = pkgs.yaziPlugins.zoom;
      };
      blender-preview = {
        package = "${blenderPreview}";
      };
      spot-image = {
        package = "${alamPlugins}/spot-image.yazi";
      };
      spot-audio = {
        package = "${alamPlugins}/spot-audio.yazi";
      };
      spot-video = {
        package = "${alamPlugins}/spot-video.yazi";
      };
      ouch = {
        package = pkgs.yaziPlugins.ouch;
      };
      compress = {
        package = pkgs.yaziPlugins.compress;
      };
    };

    # general yazi settings
    settings = {
      plugin = {
        # Priority goes from top to bottom
        prepend_preloaders = [
          {
            url = "*.blend";
            run = "blender-preview";
          }
          {
            url = "*.blend1";
            run = "blender-preview";
          }
        ];
        prepend_previewers = [
          {
            url = "*.blend";
            run = "blender-preview";
          }
          {
            url = "*.blend1";
            run = "blender-preview";
          }
        ];
        prepend_spotters = [
          {
            mime = "image/*";
            run = "spot-image";
          }
          {
            mime = "video/*";
            run = "spot-video";
          }
          {
            mime = "audio/*";
            run = "spot-audio";
          }
          {
            url = "*/";
            run = "spot";
          }
        ];
      };
    };

    # yazi keybinds
    keymap = {
      mgr.prepend_keymap = [
        /*nixfmt:disable*/
        {
          on   = [ "<C-i>" ];
          run  = "plugin fchar";
          desc = "Jump to char";
        }
        {
          on   = [ "b" ];
          run  = "plugin ouch";
          desc = "Compress with ouch";
        }
        {
          on   = "=";
          run  = "plugin zoom 1";
          desc = "Zoom in hovered file";
        }
        {
          on   = "-";
          run  = "plugin zoom -1";
          desc = "Zoom out hovered file";
        }
        /*nixfmt:enable*/
      ];
    };
  };
}
