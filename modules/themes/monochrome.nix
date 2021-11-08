{ pkgs, lib, config, ... }:

let
  inherit (pkgs) neovimPlugins;
  inherit (lib) mkEnableOption;

  cfg = config.vim.theme;
in
{
  options.vim.theme = {
    monochrome.enable = mkEnableOption "Enable monochrome theme";
  };

  config = {
    vim.startPlugins = with neovimPlugins; [ monochrome ];

    vim.luaConfigRC = ''
      vim.cmd[[colorscheme monochrome]]
    '';
  };
}
