{ pkgs, config, lib, ... }:

let
  inherit (pkgs) neovimPlugins;
in
{
  config = {
    vim.startPlugins = with neovimPlugins; [
      vim-rescript
      editorconfig-vim
      true-zen
      emmet-vim
      codi-vim
      dashboard-nvim
      surround-nvim
      vimtex
      direnv-vim
      vim-matchup
      nvim-comment
      neoscroll
      # bullets-vim
      vim-highlightedyank
      nvim-autopairs
      vim-haskell-module-name
      vim-elixir
      earthly-vim
      nvim-neoclip
      pkgs.vimPlugins.presenting-vim
    ];

    vim.luaConfigRC = ''
      require('neoclip').setup()
      require('colorizer').setup()
      require('nvim_comment').setup()
      require('true-zen').setup()
      require('nvim-web-devicons').setup({ default = true })
      require('nvim-autopairs').setup({
          disable_filetype = { "TelescopePrompt" , "vim" },
      })
      require('neoscroll').setup({ hide_cursor = false })
      require"surround".setup {mappings_style = "surround"}
    '';
  };
}
