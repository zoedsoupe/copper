{ pkgs, ... }:

with pkgs;

let
  plugins = vimPlugins // callPackage ./custom-neovim-plugins.nix { };

  pluginWithDeps = plugin: deps: plugin.overrideAttrs (_: { dependencies = deps; });

  pluginWithConfig = plugin: {
    plugin = plugin;
    config = "lua require('matthew.${plugin.pname}')";
  };

  extraPlugins = with plugins; [
    popup-nvim
    plenary-nvim
  ];

  mk-treesitter-parser = lang: { lname = lang, path = "${lang}.so" };

  treesitter-parsers = [
    (mk-treesitter-parser "bash")
    (mk-treesitter-parser "bibtex")
    (mk-treesitter-parser "c")
    (mk-treesitter-parser "clojure")
    (mk-treesitter-parser "commonlisp")
    (mk-treesitter-parser "css")
    (mk-treesitter-parser "dockerfile")
    (mk-treesitter-parser "elixir")
    (mk-treesitter-parser "elm")
    (mk-treesitter-parser "erlang")
    (mk-treesitter-parser "fish")
    (mk-treesitter-parser "haskell")
    (mk-treesitter-parser "html")
    (mk-treesitter-parser "javascript")
    (mk-treesitter-parser "json")
    (mk-treesitter-parser "latex")
    (mk-treesitter-parser "lua")
    (mk-treesitter-parser "nix")
    (mk-treesitter-parser "ocaml")
    (mk-treesitter-parser "python")
    (mk-treesitter-parser "rust")
    (mk-treesitter-parser "toml")
    (mk-treesitter-parser "tsx")
    (mk-treesitter-parser "typescript")
    (mk-treesitter-parser "vim")
    (mk-treesitter-parser "yaml")
  ];

  mk-nvim-parser = parser: xgd.configFile."nvim/parser/${parser.path}".source = "${tree-sitter.builtGrammars."${parser.lname}"}/parser"};
in
{
  xdg.configFile."nvim/lua".source = ./lua;

  map mk-nvim-parser treesitter-parsers

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
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
        neoclip
        nvim-comment
        neoformat
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
        (pluginWithDeps telescope-media
          [
            fd
            ffmpegthumbnailer
            fontpreview
            ueberzug
          ])
      ] ++ map pluginWithConfig [
        vim-polyglot
        gitsigns-nvim
        (pluginWithDeps nvim-treesitter [ gcc tree-sitter ])
        (pluginWithDeps nvim-tree-lua [ nvim-web-devicons ])
        (pluginWithDeps galaxyline-nvim [ nvim-web-devicons ])
      ] ++ extraPlugins;
  };
}
