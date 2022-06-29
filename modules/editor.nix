{ pkgs, config, lib, ... }:

let
  inherit (pkgs) neovimPlugins;
  inherit (lib) mkEnableOption mkOption;
  inherit (lib.types) bool;

  cfg = config.vim.editor;
in
{
  options.vim.editor = {
    indentGuide = mkEnableOption "Enable indent guides";
    colourPreview = mkOption {
      description = "Enable colour previews";
      type = bool;
      default = true;
    };
  };

  config = {
    vim.startPlugins = with neovimPlugins; [
      (if cfg.indentGuide then indent-blankline-nvim-lua else null)
      nvim-colorizer-lua
      nvim-which-key
    ];

    vim.nnoremap = {
      "<leader>wc" = "<cmd>close<cr>";
      "<leader>wh" = "<cmd>split<cr>";
      "<leader>wv" = "<cmd>vsplit<cr>";
    };

    vim.luaConfigRC = ''
      local wk = require("which-key")

      wk.register({
        w = {
          name = "window",
          c = { "Close Window"},
          h = { "Split Horizontal" },
          v = { "Split Vertical" },
        },
      }, { prefix = "<leader>" })

      ${if cfg.indentGuide then ''
         require("indent_blankline").setup({
             char = "|",
             buftype_exclude = { "terminal" },
             show_trailing_blankline_indent = false,
             show_first_indent_level = false,
             filetype_exclude = { "help", "terminal", "dashboard" }
         })
      '' else ""}
     
    '';
  };
}
