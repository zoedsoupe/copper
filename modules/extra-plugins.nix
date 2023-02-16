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
      codi-vim
      dashboard-nvim
      direnv-vim
      vim-matchup
      nvim-comment
      neoscroll
      # bullets-vim
      vim-highlightedyank
      vim-elixir
      earthly-vim
      pkgs.vimPlugins.presenting-vim
    ];

    vim.luaConfigRC = ''
      require('colorizer').setup()
      require('nvim_comment').setup()
      require('true-zen').setup()
      require('nvim-web-devicons').setup({ default = true })
      require('neoscroll').setup({ hide_cursor = false })
    '';
  };
}
