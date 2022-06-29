{ pkgs, lib, config, ... }:

let
  inherit (pkgs) neovimPlugins;
  inherit (lib) mkEnableOption mkIf mkOption types;
in
{
  options.vim.treesitter = {
    enable = mkOption {
      type = types.bool;
      description = "enable tree-sitter [nvim-treesitter]";
    };
  };

  config = {
    vim.startPlugins = with neovimPlugins; [
      nvim-treesitter
      nvim-ts-rainbow
      nvim-treesitter-rescript
      nvim-ts-autotag
      nvim-treesitter-context
    ];

    vim.configRC = ''
      " Tree-sitter based folding
      set foldmethod=expr
      set foldexpr=nvim_treesitter#foldexpr()
      set nofoldenable
    '';

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
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
          },
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
