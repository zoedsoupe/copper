{
  description = "Math's neovim config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    neovim = {
      url = "github:neovim/neovim?dir=contrib";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };

    vim-rescript = { url = "github:rescript-lang/vim-rescript"; flake = false };
    editorconfig-vim = { url = "github:rescript-lang/vim-rescript"; flake = false };
    true-zen = { url = "github:rescript-lang/vim-rescript"; flake = false };
    emmet-vim = { url = "github:rescript-lang/vim-rescript"; flake = false };
    nvim-ts-rainbow = { url = "github:rescript-lang/vim-rescript"; flake = false };
    codi-vim = { url = "github:rescript-lang/vim-rescript"; flake = false };
    vim-surround = { url = "github:rescript-lang/vim-rescript"; flake = false };
    vimtex = { url = "github:rescript-lang/vim-rescript"; flake = false };
    direnv-vim = { url = "github:rescript-lang/vim-rescript"; flake = false };
    ultisnips = { url = "github:rescript-lang/vim-rescript"; flake = false };
    vim-matchup = { url = "github:rescript-lang/vim-rescript"; flake = false };
    vim-snippets = { url = "github:rescript-lang/vim-rescript"; flake = false };
    nvim-comment = { url = "github:rescript-lang/vim-rescript"; flake = false };
    neoscroll = { url = "github:rescript-lang/vim-rescript"; flake = false };
    bullets-vim = { url = "github:rescript-lang/vim-rescript"; flake = false };
    telescope-nvim = { url = "github:rescript-lang/vim-rescript"; flake = false };
    vim-highlightedyank = { url = "github:rescript-lang/vim-rescript"; flake = false };
    nvim-colorizer-lua = { url = "github:rescript-lang/vim-rescript"; flake = false };
    dashboard-nvim = { url = "github:rescript-lang/vim-rescript"; flake = false };
    nvim-autopairs = { url = "github:rescript-lang/vim-rescript"; flake = false };
    vim-haskell-module-name = { url = "github:rescript-lang/vim-rescript"; flake = false };
    indent-blankline-nvim-lua = { url = "github:rescript-lang/vim-rescript"; flake = false };
    monochrome = { url = "github:rescript-lang/vim-rescript"; flake = false };
    neon = { url = "github:rescript-lang/vim-rescript"; flake = false };
    vim-polyglot = { url = "github:rescript-lang/vim-rescript"; flake = false };
    nvim-base16 = { url = "github:rescript-lang/vim-rescript"; flake = false };
    gitsigns-nvim = { url = "github:rescript-lang/vim-rescript"; flake = false };
    nvim-treesitter = { url = "github:rescript-lang/vim-rescript"; flake = false };
    nvim-tree-lua = { url = "github:rescript-lang/vim-rescript"; flake = false };
    galaxyline-nvim = { url = "github:rescript-lang/vim-rescript"; flake = false };
  };

  outputs = { nixpkgs, flake-utils, neovim, ... }@inputs:
    flake-utils.lib.eachDefaultSystem (sys:
      let
        inherit (lib) pluginOverlay neovimWrapper;

        lib = import ./lib { inherit pkgs inputs plugins; };

        plugins = [
          "vim-rescript"
          "editorconfig-vim"
          "true-zen"
          "emmet-vim"
          "nvim-ts-rainbow"
          "codi-vim"
          "vim-surround"
          "vimtex"
          "direnv-vim"
          "ultisnips"
          "vim-matchup"
          "vim-snippets"
          "nvim-comment"
          "neoscroll"
          "bullets-vim"
          "telescope-nvim"
          "vim-highlightedyank"
          "nvim-colorizer-lua"
          "dashboard-nvim"
          "nvim-autopairs"
          "vim-haskell-module-name"
          "indent-blankline-nvim-lua"
          "monochrome"
          "neon"
          "vim-polyglot"
          "nvim-base16"
          "gitsigns-nvim"
          "nvim-treesitter"
          "nvim-tree-lua"
          "galaxyline-nvim"
        ];

        pkgs = import nixpkgs {
          inherit sys;
          config = { allowUnfree = true; };
          overlays = [
            pluginOverlay
            (final: prev: {
              neovim-nightly = neovim.defaultPackage.${sys};
            })
          ];
        };
      in rec {
        inherit neovimWrapper pkgs;
        inherit (pkgs) neovimPlugins;

        apps = {
          nvim = {
            type = "app";
            program = "${defaultPackage}/bin/nvim";
          };
        };

        defaultApp = apps.nvim;
        defaultPackage = packages.neovimMT;

        overlay = (self: super: {
          inherit neovimWrapper neovimPlugins;
          neovimMT = packages.neovimMT;
        });

        packages.neovimMT = neovimWrapper {
          config.vim = {
            viAlias = true;
            vimAlias = true;
            theme.spacegray.enable = true;
            disableArrows = true;
            git.enable = true;
            editor.indentGuide = true;
          };
        };
      });
}
