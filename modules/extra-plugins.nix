{ pkgs, config, lib, ...}:

let
  inherit (pkgs) neovimPlugins;
in {
  config = {
    vim.startPlugins = with neovimPlugins; [
      vim-rescript
      editorconfig-vim
      true-zen
      emmet-vim
      codi-vim
      dashboard-nvim
      vim-surround
      vimtex
      direnv-vim
      ultisnips
      vim-matchup
      vim-snippets
      nvim-comment
      neoscroll
      # bullets-vim
      vim-highlightedyank
      nvim-autopairs
      vim-haskell-module-name
      vim-elixir
      earthly-vim
    ];

    vim.luaConfigRC = ''
      require('colorizer').setup()
      require('nvim_comment').setup()
      require('true-zen').setup()
      require('nvim-web-devicons').setup({ default = true })
      require('nvim-autopairs').setup({
          disable_filetype = { "TelescopePrompt" , "vim" },
      })
      require('neoscroll').setup({ hide_cursor = false })
    '';
  };
}
