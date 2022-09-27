{
  description = "Zoey's neovim config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    neovim = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # LSP plugins
    coc-nvim = {
      url = "github:neoclide/coc.nvim/release";
      flake = false;
    };

    nvim-lspconfig = {
      url = "github:neovim/nvim-lspconfig";
      flake = false;
    };

    lspsaga = {
      url = "github:tami5/lspsaga.nvim";
      flake = false;
    };

    lspkind = {
      url = "github:onsails/lspkind-nvim";
      flake = false;
    };

    trouble = {
      url = "github:folke/trouble.nvim";
      flake = false;
    };

    nvim-code-action-menu = {
      url = "github:weilbith/nvim-code-action-menu";
      flake = false;
    };

    lsp-signature = {
      url = "github:ray-x/lsp_signature.nvim";
      flake = false;
    };

    null-ls = {
      url = "github:jose-elias-alvarez/null-ls.nvim";
      flake = false;
    };

    nvim-dap = {
      url = "github:mfussenegger/nvim-dap";
      flake = false;
    };

    nvim-dap-ui = {
      url = "github:rcarriga/nvim-dap-ui";
      flake = false;
    };

    rnix-lsp.url = "github:nix-community/rnix-lsp";

    # Telescope
    telescope-nvim = {
      url = "github:nvim-telescope/telescope.nvim";
      flake = false;
    };

    telescope-ui-select = {
      url = "github:nvim-telescope/telescope-ui-select.nvim";
      flake = false;
    };

    # Registers
    nvim-neoclip = {
      url = "github:AckslD/nvim-neoclip.lua";
      flake = false;
    };

    # Treesitter
    nvim-treesitter = {
      url = "github:nvim-treesitter/nvim-treesitter";
      flake = false;
    };

    nvim-treesitter-rescript = {
      url = "github:nkrkv/nvim-treesitter-rescript";
      flake = false;
    };

    nvim-ts-rainbow = {
      url = "github:p00f/nvim-ts-rainbow";
      flake = false;
    };

    nvim-ts-autotag = {
      url = "github:windwp/nvim-ts-autotag";
      flake = false;
    };

    nvim-treesitter-context = {
      url = "github:lewis6991/nvim-treesitter-context";
      flake = false;
    };

    # Language specific
    earthly-vim = {
      url = "github:earthly/earthly.vim";
      flake = false;
    };

    vim-rescript = {
      url = "github:rescript-lang/vim-rescript";
      flake = false;
    };

    editorconfig-vim = {
      url = "github:editorconfig/editorconfig-vim";
      flake = false;
    };

    vim-haskell-module-name = {
      url = "github:UnkindPartition/vim-hs-module-name";
      flake = false;
    };

    vim-polyglot = {
      url = "github:sheerun/vim-polyglot";
      flake = false;
    };

    emmet-vim = {
      url = "github:mattn/emmet-vim";
      flake = false;
    };

    vimtex = {
      url = "github:lervag/vimtex";
      flake = false;
    };

    direnv-vim = {
      url = "github:direnv/direnv.vim";
      flake = false;
    };

    vim-elixir = {
      url = "github:elixir-editors/vim-elixir";
      flake = false;
    };

    # Buffer tools
    bufdelete-nvim = {
      url = "github:famiu/bufdelete.nvim";
      flake = false;
    };

    bufferline-nvim = {
      url = "github:akinsho/bufferline.nvim";
      flake = false;
    };

    # Visual
    nvim-web-devicons = {
      url = "github:kyazdani42/nvim-web-devicons";
      flake = false;
    };

    gitsigns-nvim = {
      url = "github:lewis6991/gitsigns.nvim";
      flake = false;
    };

    indent-blankline-nvim-lua = {
      url = "github:lukas-reineke/indent-blankline.nvim";
      flake = false;
    };

    true-zen = {
      url = "github:Pocco81/TrueZen.nvim";
      flake = false;
    };

    vim-highlightedyank = {
      url = "github:machakann/vim-highlightedyank";
      flake = false;
    };

    neoscroll = {
      url = "github:karb94/neoscroll.nvim";
      flake = false;
    };

    nvim-colorizer-lua = {
      url = "github:norcalli/nvim-colorizer.lua";
      flake = false;
    };

    dashboard-nvim = {
      url = "github:glepnir/dashboard-nvim";
      flake = false;
    };

    nvim-autopairs = {
      url = "github:windwp/nvim-autopairs";
      flake = false;
    };

    # Themes
    material-nvim = {
      url = "github:marko-cerovac/material.nvim";
      flake = false;
    };

    omni = {
      url = "github:getomni/neovim";
      flake = false;
    };

    melange = {
      url = "github:savq/melange";
      flake = false;
    };

    boo = {
      url = "github:rockerBOO/boo-colorscheme-nvim";
      flake = false;
    };

    doom-one = {
      url = "github:NTBBloodbath/doom-one.nvim";
      flake = false;
    };

    rose-pine = {
      url = "github:rose-pine/neovim";
      flake = false;
    };

    # Extra
    plenary-nvim = {
      url = "github:nvim-lua/plenary.nvim";
      flake = false;
    };

    codi-vim = {
      url = "github:metakirby5/codi.vim";
      flake = false;
    };

    surround-nvim = {
      url = "github:ur4ltz/surround.nvim";
      flake = false;
    };

    vim-matchup = {
      url = "github:andymass/vim-matchup";
      flake = false;
    };

    nvim-comment = {
      url = "github:terrortylor/nvim-comment";
      flake = false;
    };

    bullets-vim = {
      url = "github:dkarter/bullets.vim";
      flake = false;
    };

    nvim-tree-lua = {
      url = "github:kyazdani42/nvim-tree.lua";
      flake = false;
    };

    galaxyline-nvim = {
      url = "github:glepnir/galaxyline.nvim";
      flake = false;
    };

    popup-nvim = {
      url = "github:nvim-lua/popup.nvim";
      flake = false;
    };

    vimagit = {
      url = "github:jreybert/vimagit";
      flake = false;
    };

    nvim-which-key = {
      url = "github:folke/which-key.nvim";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";

      lib = import ./lib.nix { inherit pkgs inputs; };

      inherit (import ./overlays.nix {
        inherit system inputs lib;
      }) overlays;

      pkgs = import nixpkgs {
        inherit system overlays;

        config.allowUnfree = true;
      };
    in
    rec {
      inherit (lib) mkNeovim;

      apps."${system}" = rec {
        default = nvim;

        nvim = {
          type = "app";
          programs = "${packages."${system}".default}/bin/nvim";
        };
      };

      devShells."${system}".default = pkgs.mkShell {
        buildInputs = [ packages."${system}".copper ];
      };

      overlays.default = super: self: {
        inherit mkNeovim;
        inherit (pkgs) neovimPlugins;

        copper = packages."${system}".copper;
      };

      packages."${system}" = rec {
        default = copper;
        copper = mkNeovim {
          config = {
            vim.viAlias = true;
            vim.vimAlias = true;
            vim.tabline.nvimBufferline.enable = true;
            vim.treesitter.enable = true;
            vim.theme = {
              enable = true;
              name = "rose-pine";
              # style = "radioactive_waste";
            };
            vim.disableArrows = true;
            vim.editor.indentGuide = true;
            vim.lsp = {
              autocomplete.enable = true;
              enable = true;
              nvimCodeActionMenu.enable = true;
              formatOnSave = true;
              trouble.enable = true;
              lspsaga.enable = true;
              nix = true;
              rust = true;
              elixir = true;
              debugger = {
                enable = true;
                elixir = true;
              };
            };
          };
        };
      };
    };
}
