{ pkgs, lib, ... }:

with pkgs;

let
  plugins = vimPlugins // callPackage ./custom-neovim-plugins.nix { };

  pluginWithDeps = plugin: deps: plugin.overrideAttrs (_: { dependencies = deps; });

  pluginWithConfig = plugin: {
    plugin = plugin;
    config =
      let replace = (f: t: s: lib.stringAsChars (c: if c == f then t else c) s);
      in
      if builtins.hasAttr "pname" plugin
      then "lua require('matthew.${replace "." "-" plugin.pname}')"
      else "lua require('matthew.${replace "." "-" plugin.name}')";
  };

  extraPlugins = with plugins; [
    popup-nvim
    plenary-nvim
  ];
in
{
  xdg.configFile."nvim/lua".source = ./lua;

  programs.neovim = {
    package = pkgs.neovim;
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
        nvim-ts-rainbow
        codi-vim
        vim-surround
        vimtex
        direnv-vim
        ultisnips
        vim-matchup
        vim-snippets
        nvim-comment
        orgmode
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
      gcc
      tree-sitter

      # telescope-media packages
      fd
      fontpreview
      ffmpegthumbnailer
      ueberzug
    ];
  };
}
