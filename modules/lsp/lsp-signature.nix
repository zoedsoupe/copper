{ pkgs, config, lib, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.vim.lsp;
in
{
  options.vim.lsp.lspSignature.enable = mkEnableOption "lsp signature viewer";

  config = mkIf (cfg.enable && cfg.lspSignature.enable) {
    vim.startPlugins = with pkgs.neovimPlugins; [ lsp-signature ];

    vim.luaConfigRC = ''
      -- Enable lsp signature viewer
      require("lsp_signature").setup()
    '';
  };
}
