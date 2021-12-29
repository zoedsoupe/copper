{ pkgs, lib, config, ... }:

let
  inherit (pkgs) neovimPlugins;
  inherit (lib) mkEnableOption mkIf;

  cfg = config.vim.theme;
in
{
  options.vim.theme = {
    calvera.enable = mkEnableOption "Enable calvera dark theme";
  };

  config = mkIf cfg.calvera.enable {
    vim.startPlugins = with neovimPlugins; [ calvera-dark ];

    vim.luaConfigRC = ''
      vim.g.calvera_italic_keywords = false
      vim.g.calvera_borders = true
      vim.g.calvera_contrast = true
      vim.g.calvera_hide_eob = true
      vim.g.calvera_custom_colors = {contrast = "#0f111a"}

      require('calvera').set()
    '';
  };
}
