{ pkgs, lib, config, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.vim.comments;
in
{
  options.vim.comments = {
    enable = mkEnableOption "Enable comment plugin";
  };

  config = mkIf cfg.enable {
    vim.startPlugins = [ pkgs.neovimPlugins.kommentary ];

    vim.luaConfigRC = ''
      -- Kommentary config
      require('kommentary.config').setup();
      require('kommentary.config').configure_language("nix", {
          single_line_comment_string = "#",
      })
    '';
  };
}
