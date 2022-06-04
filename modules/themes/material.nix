{ pkgs, lib, config, ... }:

let
  inherit (pkgs) neovimPlugins;
  inherit (lib) mkEnableOption mkIf;

  cfg = config.vim.theme;
in
{
  options.vim.theme = {
    material.enable = mkEnableOption "Enable material theme";
  };

  config = mkIf cfg.material.enable {
    vim.startPlugins = with neovimPlugins; [ material-nvim ];

    vim.luaConfigRC = ''
      vim.g.material_style = "palenight"

      require('material').setup({
        italics = {
          comments = true,
        },
      })

      vim.cmd[[colorscheme material]]
    '';
  };
}
