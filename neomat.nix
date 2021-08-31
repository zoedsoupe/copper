{ pkgs, ... }:

with pkgs;

let
  plugins = vimPlugins // callPackage ./custom-neovim-plugins.nix { };

  pluginWithDeps = plugin: deps: plugin.overrideAttrs (_: { dependencies = deps; });

  pluginWithConfig = plugin: {
    plugin = plugin;
    config = if builtins.hasAttr "pname" plugin
      then "lua require('matthew.${plugin.pname}')"
      else "lua require('matthew.${plugin.name}')";
  };

  extraPlugins = with plugins; [
    popup-nvim
    plenary-nvim
  ];
in
{
  xdg.configFile."nvim/lua".source = ./lua;

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;
    withPython3 = true;
    extraConfig = "lua require('init')\n";
    plugins = with plugins;
      [
        vim-rescript
        editorconfig-vim
        true-zen
        agda-vim
        emmet-vim
        rainbow
        vim-surround
        vimtex
        direnv-vim
        ultisnips
        vim-matchup
        vim-snippets
        nvim-comment
        neoformat
        orgmode
        vim-racket
        neoscroll
        bullets-vim
        telescope-nvim
        vim-highlightedyank
        nvim-colorizer-lua
        dashboard-nvim
        nvim-autopairs
        vim-haskell-module-name
        indent-blankline-nvim-lua
        telescope-media
      ] ++ map pluginWithConfig [
        nvim-base16
        vim-polyglot
        gitsigns-nvim
        nvim-treesitter
        (pluginWithDeps nvim-tree-lua [ nvim-web-devicons ])
        (pluginWithDeps galaxyline-nvim [ nvim-web-devicons ])
      ] ++ extraPlugins;
      extraPackages = [ 
        # nvim-treesitter packages
        gcc tree-sitter

        # telescope-media packages
        fd fontpreview
        ffmpegthumbnailer
        ueberzug
      ];
  };
}
