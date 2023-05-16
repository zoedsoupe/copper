{ pkgs, config, lib, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.vim.keys;
in
{
  options.vim.keys = {
    enable = mkEnableOption "key binding plugins";

    whichKey = {
      enable = mkEnableOption "which-key menu";
    };
  };

  config = mkIf (cfg.enable && cfg.whichKey.enable) {
    vim.startPlugins = with pkgs.neovimPlugins; [
      which-key
    ];

    vim.luaConfigRC = ''
      -- Set up which-key
      require("which-key").setup {}
    '';
  };
}
