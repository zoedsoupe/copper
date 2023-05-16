{ pkgs, config, lib, ... }:

let
  inherit (pkgs) neovimPlugins;
in
{
  config = {
    vim.startPlugins = with neovimPlugins; [
      editorconfig-vim
      true-zen
      emmet-vim
      dashboard-nvim
      direnv-vim
      vim-matchup
      neoscroll
      vim-highlightedyank
      vim-elixir
      nvim-colorizer-lua
      pkgs.vimPlugins.presenting-vim
      headlines-nvim
      codi
      todo-comments
    ];

    vim.luaConfigRC = ''
      require('colorizer').setup()
      require('true-zen').setup()
      require('nvim-web-devicons').setup({ default = true })
      require('neoscroll').setup({ hide_cursor = false })
      require('headlines').setup()
      require("todo-comments").setup()
    '';
  };
}
