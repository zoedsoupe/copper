{ config, lib, pkgs, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.vim.surround;
in
{
  options.vim.surround = {
    enable = mkEnableOption "Enable nvim-surround plugin";
  };

  config = mkIf cfg.enable
    {
      vim.startPlugins = [ pkgs.neovimPlugins.nvim-surround ];

      vim.luaConfigRC = ''
        require('nvim-surround').setup()
      '';
    };
}
