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
      type = enum [ "material" "omni" ];
    };

    style = mkOption {
      description = "Sets theme style";
      default = "palenight";
      type = str;
    };
  };

  config = mkIf cfg.enable {
    vim.startPlugins = with neovimPlugins; if cfg.name == "material" then [ material-nvim ] else if cfg.name == "omni" then [ omni ] else [ ];

    vim.luaConfigRC =
      if cfg.name == "material" then ''
        vim.g.material_style = "${cfg.style}"
        require('material').setup({
          italics = {
            comments = true,
          },
        })
        vim.cmd[[colorscheme material]]
      '' else if cfg.name == "omni" then ''
        vim.cmd[[colorscheme omni]]
      '' else "";
  };
}
