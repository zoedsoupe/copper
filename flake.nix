{
  description = "Zoey's neovim config";

  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixpkgs-unstable;
    flake-utils.url = github:numtide/flake-utils;

    neovim = {
      url = github:nix-community/neovim-nightly-overlay;
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Autocompletes
    nvim-compe = {
      url = github:hrsh7th/nvim-compe;
      flake = false;
    };

    nvim-cmp = {
      url = github:hrsh7th/nvim-cmp;
      flake = false;
    };

    cmp-buffer = {
      url = github:hrsh7th/cmp-buffer;
      flake = false;
    };

    cmp-nvim-lsp = {
      url = github:hrsh7th/cmp-nvim-lsp;
      flake = false;
    };

    cmp-vsnip = {
      url = github:hrsh7th/cmp-vsnip;
      flake = false;
    };

    cmp-path = {
      url = github:hrsh7th/cmp-path;
      flake = false;
    };

    cmp-treesitter = {
      url = github:ray-x/cmp-treesitter;
      flake = false;
    };

    # Snippets
    vim-vsnip = {
      url = github:hrsh7th/vim-vsnip;
      flake = false;
    };

    # LSP plugins
    nvim-lspconfig = {
      url = github:neovim/nvim-lspconfig;
      flake = false;
    };

    lspsaga = {
      url = github:tami5/lspsaga.nvim;
      flake = false;
    };

    lspkind = {
      url = github:onsails/lspkind-nvim;
      flake = false;
    };

    trouble = {
      url = github:folke/trouble.nvim;
      flake = false;
    };

    nvim-code-action-menu = {
      url = github:weilbith/nvim-code-action-menu;
      flake = false;
    };

    lsp-signature = {
      url = github:ray-x/lsp_signature.nvim;
      flake = false;
    };

    null-ls = {
      url = github:jose-elias-alvarez/null-ls.nvim;
      flake = false;
    };

    nvim-lightbulb = {
      url = github:kosayoda/nvim-lightbulb;
      flake = false;
    };

    rust-tools = {
      url = github:simrat39/rust-tools.nvim;
      flake = false;
    };

    rnix-lsp.url = github:nix-community/rnix-lsp;

    # Commenting
    kommentary = {
      url = github:b3nj5m1n/kommentary;
      flake = false;
    };

    todo-comments = {
      url = github:folke/todo-comments.nvim;
      flake = false;
    };

    # Folds
    nvim-ufo = {
      url = github:kevinhwang91/nvim-ufo;
      flake = false;
    };

    promise-async = {
      url = github:kevinhwang91/promise-async; # required by nvim-ufo
      flake = false;
    };

    # Telescope
    telescope = {
      url = github:nvim-telescope/telescope.nvim;
      flake = false;
    };

    telescope-ui-select = {
      url = github:nvim-telescope/telescope-ui-select.nvim;
      flake = false;
    };

    # Registers
    nvim-neoclip = {
      url = github:AckslD/nvim-neoclip.lua;
      flake = false;
    };

    # Treesitter
    nvim-treesitter = {
      url = github:nvim-treesitter/nvim-treesitter;
      flake = false;
    };

    nvim-ts-rainbow = {
      url = github:p00f/nvim-ts-rainbow;
      flake = false;
    };

    nvim-ts-autotag = {
      url = github:windwp/nvim-ts-autotag;
      flake = false;
    };

    nvim-treesitter-context = {
      url = github:lewis6991/nvim-treesitter-context;
      flake = false;
    };

    # Language specific
    earthly-vim = {
      url = github:earthly/earthly.vim;
      flake = false;
    };

    typescript-nvim = {
      url = github:/jose-elias-alvarez/typescript.nvim;
      flake = false;
    };

    editorconfig-vim = {
      url = github:editorconfig/editorconfig-vim;
      flake = false;
    };

    vim-polyglot = {
      url = github:sheerun/vim-polyglot;
      flake = false;
    };

    emmet-vim = {
      url = github:mattn/emmet-vim;
      flake = false;
    };

    vimtex = {
      url = github:lervag/vimtex;
      flake = false;
    };

    direnv-vim = {
      url = github:direnv/direnv.vim;
      flake = false;
    };

    vim-elixir = {
      url = github:elixir-editors/vim-elixir;
      flake = false;
    };

    conjure = {
      url = github:Olical/conjure;
      flake = false;
    };

    vim-sexp = {
      url = github:guns/vim-sexp;
      flake = false;
    };

    vim-sexp-mappings = {
      url = github:tpope/vim-sexp-mappings-for-regular-people;
      flake = false;
    };

    # Buffer tools
    bufdelete-nvim = {
      url = github:famiu/bufdelete.nvim;
      flake = false;
    };

    nvim-bufferline = {
      url = github:akinsho/bufferline.nvim;
      flake = false;
    };

    # Visual
    nvim-web-devicons = {
      url = github:kyazdani42/nvim-web-devicons;
      flake = false;
    };

    gitsigns-nvim = {
      url = github:lewis6991/gitsigns.nvim;
      flake = false;
    };

    nvim-cursorline = {
      url = github:yamatsum/nvim-cursorline;
      flake = false;
    };

    indent-blankline = {
      url = github:lukas-reineke/indent-blankline.nvim;
      flake = false;
    };

    true-zen = {
      url = github:Pocco81/TrueZen.nvim;
      flake = false;
    };

    vim-highlightedyank = {
      url = github:machakann/vim-highlightedyank;
      flake = false;
    };

    neoscroll = {
      url = github:karb94/neoscroll.nvim;
      flake = false;
    };

    nvim-colorizer-lua = {
      url = github:norcalli/nvim-colorizer.lua;
      flake = false;
    };

    dashboard-nvim = {
      url = github:glepnir/dashboard-nvim;
      flake = false;
    };

    nvim-autopairs = {
      url = github:windwp/nvim-autopairs;
      flake = false;
    };

    # Themes
    doom-one = {
      url = github:NTBBloodbath/doom-one.nvim;
      flake = false;
    };

    rosepine = {
      url = github:rose-pine/neovim;
      flake = false;
    };

    catppuccin = {
      url = github:catppuccin/nvim;
      flake = false;
    };

    # Extra
    plenary-nvim = {
      url = github:nvim-lua/plenary.nvim;
      flake = false;
    };

    codi-vim = {
      url = github:metakirby5/codi.vim;
      flake = false;
    };

    nvim-surround = {
      url = github:kylechui/nvim-surround;
      flake = false;
    };

    vim-matchup = {
      url = github:andymass/vim-matchup;
      flake = false;
    };

    nvim-comment = {
      url = github:terrortylor/nvim-comment;
      flake = false;
    };

    bullets-vim = {
      url = github:dkarter/bullets.vim;
      flake = false;
    };

    nvim-tree-lua = {
      url = github:kyazdani42/nvim-tree.lua;
      flake = false;
    };

    headlines-nvim = {
      url = github:lukas-reineke/headlines.nvim;
      flake = false;
    };

    # Statuslines
    lualine = {
      url = github:hoob3rt/lualine.nvim;
      flake = false;
    };

    popup-nvim = {
      url = github:nvim-lua/popup.nvim;
      flake = false;
    };

    vimagit = {
      url = github:jreybert/vimagit;
      flake = false;
    };

    which-key = {
      url = github:folke/which-key.nvim;
      flake = false;
    };

    codi = {
      url = github:metakirby5/codi.vim;
      flake = false;
    };
  };

  outputs = { self, nixpkgs, flake-utils, ... }@inputs:
    flake-utils.lib.eachDefaultSystem (system:
      let
        lib = import ./lib.nix { inherit pkgs inputs; };

        inherit (import ./overlays.nix {
          inherit system inputs lib;
        }) overlays;

        libOverlay = f: p: {
          lib = p.lib.extend (_: _: {
            inherit (lib) withPlugins writeIf mkVimBool withAttrSet;
          });
        };

        pkgs = import nixpkgs {
          inherit system;

          overlays = overlays ++ [ libOverlay ];
          config.allowUnfree = true;
        };

        config = {
          vim = {
            viAlias = false;
            vimAlias = false;
            disableArrows = true;
            preventJunkFiles = true;
            cmdHeight = 2;
            treesitter.enable = true;
            visuals = {
              enable = true;
              nvimWebDevicons.enable = true;
              lspkind.enable = true;
              indentBlankline = {
                enable = true;
                fillChar = "";
                eolChar = "";
                showCurrContext = true;
              };
              cursorWordline = {
                enable = true;
                lineTimeout = 0;
              };
            };
            statusline.lualine = {
              enable = true;
              theme = "catppuccin";
            };
            theme = {
              enable = true;
              name = "catppuccin";
              style = "macchiato";
              transparency = false;
            };
            autopairs.enable = true;
            neoclip.enable = true;
            autocomplete = {
              enable = true;
              type = "nvim-cmp";
            };
            filetree.nvimTreeLua = {
              enable = true;
              hideDotFiles = false;
              hideFiles = [ "node_modules" ".cache" ];
            };
            tabline.nvimBufferline.enable = true;
            keys = {
              enable = true;
              whichKey.enable = true;
            };
            comments = {
              enable = true;
              type = "kommentary";
            };
            shortcuts = {
              enable = true;
            };
            surround = {
              enable = true;
            };
            telescope = {
              enable = true;
            };
            git = {
              enable = true;
              gitsigns.enable = true;
            };
            lsp = {
              enable = true;
              folds = true;
              formatOnSave = false;
              lightbulb.enable = true;
              lspsaga.enable = false;
              nvimCodeActionMenu.enable = true;
              trouble.enable = true;
              lspSignature.enable = true;
              nix = {
                enable = true;
                type = "nil";
              };
              rust.enable = true;
              ts = true;
              vue = true;
              elm = false;
              elixir = true;
              clojure = true;
            };
          };
        };
      in
      rec {
        apps = rec {
          neovim = {
            type = "app";
            program = "${packages.default}/bin/nvim";
          };
          default = neovim;
        };

        overlays.default = super: self: {
          inherit (lib) mkNeovim;
          inherit (pkgs) neovimPlugins;

          copper = packages.copper;
        };

        packages = rec {
          default = copper;
          copper = lib.mkNeovim { inherit config; };
        };

        devShells.default = pkgs.mkShell {
          buildInputs = [ packages.copper ];
        };
      });
}
