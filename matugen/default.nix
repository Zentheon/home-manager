#
# Dynamic Material You-coded app theming
#
{
  config,
  matugen,
  ...
}:

let
  templates = fetchTree {
    type = "git";
    url = "https://github.com/InioX/matugen-themes.git";
    rev = "707c7b7d3550c9c21c0a8d72186748b1d205b88b";
  };
  matugenConfig = ''
    [config]

    [templates.feishin-css]
    input_path = '${config.xdg.configHome}/home-manager/matugen/config/feishin.css'
    output_path = '${config.xdg.configHome}/feishin/Themes/overrides/matugen.css'

    [templates.feishin]
    input_path = '${config.xdg.configHome}/home-manager/matugen/config/feishin.json'
    output_path = '${config.xdg.configHome}/feishin/Themes/matugen.json'

    [templates.feishin-colorful]
    input_path = '${config.xdg.configHome}/home-manager/matugen/config/feishin-colorful.json'
    output_path = '${config.xdg.configHome}/feishin/Themes/matugen-colorful.json'

    [templates.discord-system24]
    input_path = '${templates}/templates/system24.css'
    output_path = '${config.xdg.configHome}/vesktop/themes/system24.css'

    [templates.yazi]
    input_path = '${templates}/templates/yazi-theme.toml'
    output_path = '${config.xdg.configHome}/yazi/theme.tomle'
  '';
  zenCss = ''
    @import url("${templates}/templates/zen-usercontent.css");
    @import url("${templates}/templates/zen-userchrome.css");
  '';
in
{
  home.file."${config.xdg.configHome}/matugen/config.toml".text = "${matugenConfig}";

  home.file."${config.home.homeDirectory}/.zen/chrome/userContent.css".text = "${zenCss}";
  home.file."${config.home.homeDirectory}/.zen/chrome/userChrome.css".text = "${zenCss}";

  imports = [
    matugen.nixosModules.default
  ];

  # DankMaterialShell has its own matugen thing already. It sources the additional configs
  # programs.matugen = {
  #   enable = true;
  #   # variant = "dark";
  #   # jsonFormat = "hex";
  #   # palette = "default";
  #
  #   templates = {
  #     yazi = {
  #       input_path = "/home/zentheon/.config/home-manager/matugen/templates/yazi.toml";
  #       output_path = "$XDG_CONFIG_HOME/yazi/theme.toml";
  #     };
  #     feishin = {
  #       input_path = "/home/zentheon/.config/home-manager/matugen/feishin.json";
  #       output_path = "$XDG_CONFIG_HOME/feishin/Themes/matugen.json";
  #     };
  #   };
  # };
  # gtk = {
  #   gtk4.extraCss = "@import url(\"${config.programs.matugen.theme.files}/.config/gtk-4.0/gtk.css\");";
  #   gtk3.extraCss = "@import url(\"${config.programs.matugen.theme.files}/.config/gtk-3.0/gtk.css\");";
  # };
  # ...
}
