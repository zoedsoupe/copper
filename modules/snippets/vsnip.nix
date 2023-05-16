{ pkgs, config, lib, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.vim.snippets.vsnip;
in
{
  options.vim.snippets.vsnip = {
    enable = mkEnableOption "Enable vim-vsnip";
  };

  config = mkIf cfg.enable {
    vim.startPlugins = with pkgs.neovimPlugins; [ vim-vsnip ];
  };
}
