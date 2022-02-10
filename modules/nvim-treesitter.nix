{ pkgs, lib, config, ... }:

let
  inherit (pkgs) neovimPlugins;
in
{
  config = {
    vim.startPlugins = with neovimPlugins; [ 
      nvim-treesitter 
      nvim-ts-rainbow
      nvim-treesitter-rescript
    ];

    vim.luaConfigRC = ''
      local present, ts_config = pcall(require, "nvim-treesitter.configs")
      
      if not present then
        return
      end

      ts_config.setup {
        ensure_installed = {
          "bash",
          "bibtex",
          "c",
          "clojure",
          "commonlisp",
          "css",
          "dockerfile",
          "elixir",
          "elm",
          "erlang",
          "fish",
          "haskell",
          "html",
          "javascript",
          "json",
          "latex",
          "lua",
          "nix",
          "ocaml",
          "python",
          "rust",
          "toml",
          "tsx",
          "typescript",
          "yaml"
        },
        highlight = {
          enable = true,
          use_languagetree = true,
        },
      }

      require('nvim-treesitter.configs').setup({
          rainbow = {
            enable = true,
            extended_mode = true,
            max_file_lines = nil
          }
      })
    '';
  };
}
