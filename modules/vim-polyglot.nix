{ pkgs, lib, config, ... }:

let
  inherit (pkgs) neovimPlugins;
in
{
  config = {
    vim.startPlugins = with neovimPlugins; [ vim-polyglot ];

    vim.globals = {
      "haskell_indent_if" = 3;
      "haskell_indent_case" = 2;
      "haskell_indent_let" = 4;
      "haskell_indent_where" = 6;
      "haskell_indent_before_where" = 2;
      "haskell_indent_after_bare_where" = 2;
      "haskell_indent_do" = 3;
      "haskell_indent_in" = 1;
      "haskell_indent_guard" = 2;
      "haskell_backpack" = 1;
      "haskell_enable_arrowsyntax" = 1;
      "haskell_enable_quantification" = 1;
      "haskell_enable_recursivedo" = 1;
      "haskell_enable_pattern_synonyms" = 1;
      "haskell_enable_static_pointers" = 1;
      "haskell_enable_typeroles" = 1;

      "vim_markdown_new_list_item_indent" = 2;
    };
  };
}
