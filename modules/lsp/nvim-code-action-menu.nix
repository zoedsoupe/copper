{ pkgs, config, lib, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.vim.lsp;
in
{
  options.vim.lsp.nvimCodeActionMenu.enable = mkEnableOption "nvim code action menu";

  config = mkIf (cfg.enable && cfg.nvimCodeActionMenu.enable) {
    vim.startPlugins = with pkgs.neovimPlugins; [
      nvim-code-action-menu
    ];

    vim.nnoremap = {
      "<silent><leader>ac" = ":CodeActionMenu<CR>";
    };
  };
}
