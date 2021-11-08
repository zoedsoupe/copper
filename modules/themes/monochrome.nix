{ pkgs, lib, config, ... }:

let
  inherit (pkgs) neovimPlugins;
  inherit (lib) mkEnableOption mkIf;

  cfg = config.vim.theme;
in
{
  options.vim.theme = {
    monochrome.enable = mkEnableOption "Enable monochrome theme";
  };

  config = mkIf cfg.monochrome.enable {
    vim.startPlugins = with neovimPlugins; [ monochrome ];

    vim.luaConfigRC = ''
      vim.cmd[[colorscheme monochrome]]
    '';
  };
}
