{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.vim.surround;
in
{
  options.vim.surround = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Enable nvim-surround plugin";
    };
  };

  config = mkIf cfg.enable
    {
      vim.startPlugins = [ pkgs.neovimPlugins.nvim-surround ];

      vim.luaConfigRC = ''
        require('nvim-surround').setup()
      '';
    };
}
