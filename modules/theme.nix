{ pkgs, lib, config, ... }:

let
  inherit (pkgs) neovimPlugins;
  inherit (lib) mkEnableOption mkOption mkIf types;
  inherit (types) enum str;

  cfg = config.vim.theme;
in
{
  options.vim.theme = {
    enable = mkEnableOption "Enable Themes config";

    name = mkOption {
      default = "material";
      description = "Sets the current theme";
      type = enum [ "material" ];
    };

    style = mkOption {
      description = "Sets theme style";
      default = "palenight";
      type = str;
    };
  };

  config = mkIf cfg.enable {
    vim.startPlugins = with neovimPlugins; [ material-nvim ];

    vim.luaConfigRC = ''
      vim.g.material_style = "${cfg.style}"
      require('material').setup({
        italics = {
          comments = true,
        },
      })
      vim.cmd[[colorscheme material]]
    '';
  };
}
