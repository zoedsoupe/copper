{ pkgs, lib, config, ... }:

let
  inherit (pkgs) neovimPlugins;
  inherit (lib) mkEnableOption mkIf;

  cfg = config.vim.theme;
in
{
  options.vim.theme = {
    sonokai.enable = mkEnableOption "Enable monochrome theme";
  };

  config = mkIf cfg.sonokai.enable {
    vim.startPlugins = with neovimPlugins; [ sonokai ];

    vim.luaConfigRC = ''
      vim.g.sonokai_style = "andromeda"
      vim.g.sonokai_enable_italic = 1
      vim.cmd[[colorscheme sonokai]]
    '';
  };
}
