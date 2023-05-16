{ pkgs, lib, config, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.vim.autopairs;
in
{
  options.vim = {
    autopairs.enable = mkEnableOption "Enable autopairing";
  };

  config = mkIf cfg.enable {
    vim.startPlugins = with pkgs.neovimPlugins; [
      nvim-autopairs
    ];

    vim.luaConfigRC = ''
      require("nvim-autopairs").setup{}
    '';
  };
}
