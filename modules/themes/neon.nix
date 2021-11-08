{ pkgs, lib, config, ... }:

let
  inherit (pkgs) neovimPlugins;
  inherit (lib) mkEnableOption mkOption mkIf;
  inherit (lib.types) enum;

  cfg = config.vim.theme;
in
{
  options.vim.theme = {
    neon = {
      enable = mkEnableOption "Enable neon theme";
      style = mkOption {
        default = "default";
        description = "There's three options to choose from, default, doom, dark and light";
        type = enum [ "default" "doom" "dark" "light" ];
      };
    };
  };

  config = mkIf cfg.neon.enable { 
    vim.startPlugins = with neovimPlugins; [ neon ];

    vim.globals = { "neon_style" = cfg.neon.style; };

    vim.luaConfigRC = ''
      vim.cmd[[colorscheme neon]]
    '';
  };
}
