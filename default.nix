{ pkgs, ... }:

let
  plugins = pkgs.vimPlugins // pkgs.callPackage ./custom-neovim-plugins.nix { };

  pluginWithDeps = plugin: deps: plugin.overrideAttrs (_: { dependencies = deps; });

  pluginWithConfig = plugin: {
    plugin = plugin;
    config = "lua require('matthew.${plugin.pname}')";
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
    extraConfig = "lua require('init')\n";
    plugins = with plugins;
      [
        vim-rescript
        editorconfig-vim
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
        (pluginsWithDeps telescope-media with pkgs; 
          [
            fd
            ffmpegthumbnailer
            fontpreview
            ueberzug
          ])
      ] ++ map pluginWithConfig [
        vim-polyglot
        gitsigns-nvim
        (pluginWithDeps nvim-tree-lua [ nvim-web-devicons ])
        (pluginWithDeps galaxyline-nvim [ nvim-web-devicons ])
      ] ++ extraPlugins;
  };
}
