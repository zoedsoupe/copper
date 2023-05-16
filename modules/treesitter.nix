{ pkgs, lib, config, ... }:

let
  inherit (pkgs) neovimPlugins;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.vim.treesitter = {
    enable = mkEnableOption "enable tree-sitter [nvim-treesitter]";
  };

  config = {
    vim.startPlugins = with neovimPlugins; [
      nvim-treesitter
      nvim-ts-rainbow
      nvim-ts-autotag
      nvim-treesitter-context
    ];

    vim.globals = {
      "foldmethod" = "expr";
      "foldexpr" = "nvim_treesitter#foldexpr()";
      "nofoldenable" = 1;
    };

    vim.luaConfigRC = ''
      require('nvim-treesitter.configs').setup({
        highlight = {
          enable = true,
          use_languagetree = true,
        },
        rainbow = {
          enable = true,
          extended_mode = true,
          max_file_lines = nil
        },
        autotag = {
          enable = true,
        },
      })

      require'treesitter-context'.setup {
        enable = true,
        throttle = true,
        max_lines = 0
      }
    '';
  };
}
