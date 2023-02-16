{ pkgs, lib, config, ... }:

let
  inherit (lib) types mkOption;
  inherit (builtins) concatStringsSep;
  inherit (types) bool int str listOf enum;

  cfg = config.vim;
in
{
  options.vim = {
    colourTerm = mkOption {
      default = true;
      description = "Set terminal up for 256 colours";
      type = bool;
    };

    concealLevel = mkOption {
      default = 0;
      description = "Show up `` on markdown and ** in org";
      type = int;
    };

    disableArrows = mkOption {
      default = false;
      description = "Set to prevent arrow keys from moving cursor";
      type = bool;
    };

    colorColumn = mkOption {
      default = "";
      description = "Comma separated list of screen columns that are highlighted with ColorColumn";
      type = str;
    };

    completeOpt = mkOption {
      default = [ ];
      description = "Completions options";
      type = listOf str;
    };

    foldMethod = mkOption {
      default = "syntax";
      description = "How to fold text blocks";
      type = str;
    };

    hlSearch = mkOption {
      default = false;
      description = "Highlight all matches of a previous search pattern";
      type = bool;
    };

    background = mkOption {
      default = "light";
      description = "Sets background color";
      type = str;
    };

    mapLeaderSpace = mkOption {
      default = true;
      description = "Map the space key to leader key";
      type = bool;
    };

    lineNumberMode = mkOption {
      default = "relNumber";
      description = "How line numbers are displayed. none relative number relNumber";
      type = enum [ "relative" "number" "relNumber" "none" ];
    };

    preventJunkFiles = mkOption {
      default = true;
      description = "Prevent swapfile backupfile from being created";
      type = bool;
    };

    tabWidth = mkOption {
      default = 2;
      description = "Set the width of tabs to 2";
      type = int;
    };

    autoIndent = mkOption {
      default = true;
      description = "Enable auto indent";
      type = bool;
    };

    cmdHeight = mkOption {
      default = 2;
      description = "Hight of the command pane";
      type = int;
    };

    updateTime = mkOption {
      default = 300;
      description = "The number of milliseconds till Cursor Hold event is fired";
      type = int;
    };

    showSignColumn = mkOption {
      default = true;
      description = "Show the sign column";
      type = bool;
    };

    bell = mkOption {
      default = "none";
      description = "Set how bells are handled. Options on visual or none";
      type = enum [ "none" "visual" "on" ];
    };

    mapTimeout = mkOption {
      default = 500;
      description = "Timeout microseconds that neovim will wait for mapped action to complete";
      type = int;
    };

    splitBelow = mkOption {
      default = true;
      description = "New splits will open below instead of on top";
      type = bool;
    };

    splitRight = mkOption {
      default = true;
      description = "New splits will open to the right";
      type = bool;
    };

    mouseSupport = mkOption {
      default = "a";
      description = "Set modes for mouse support. a - all n - normal v - visual i - insert c - command";
      type = types.str;
    };

    syntaxHighlighting = mkOption {
      default = true;
      description = "Enable syntax highlighting";
      type = bool;
    };
  };

  config = (
    let
      writeIf = cond: msg: if cond then msg else "";
    in
    {

      vim.globals = {
        "highlightedyank_highlight_duration" = 145;
        "direnv_silent_load" = 1;
        "dashboard_default_executive" = "telescope";
        "bullets_enabled_file_types" = "markdown,text,gitcommit,orgmode,scratch";
      };

      vim.nmap =
        if (cfg.disableArrows) then {
          "<up>" = "<nop>";
          "<down>" = "<nop>";
          "<left>" = "<nop>";
          "<right>" = "<nop>";
        } else { };

      vim.imap =
        if (cfg.disableArrows) then {
          "<up>" = "<nop>";
          "<down>" = "<nop>";
          "<left>" = "<nop>";
          "<right>" = "<nop>";
        } else { };

      vim.nnoremap = {
        "Y" = "y$";
        "n" = "nzzzv";
        "N" = "Nzzzv";
        "<cr>" = ":noh<cr><cr>";
        "<leader>k" = ":m .-2<cr>==";
        "<leader>j" = ":m .+1<cr>==";
        "<f12>" = "<cmd>TZAtaraxis<cr>";
      } // (if (cfg.mapLeaderSpace) then {
        "<space>" = "<nop>";
      } else { });

      vim.cnoremap = {
        "w!!" = "!sudo tee %";
      };

      vim.vnoremap = {
        "J" = ":m '>+1<cr>gv=gv";
        "K" = ":m '<-2<CR>gv=gv";
      };

      vim.inoremap = {
        "<c-j>" = "<esc>:m .+1<cr>==";
        "<c-k>" = "<esc>:m .-2<cr>==";
      };

      vim.startPlugins = [ pkgs.neovimPlugins.plenary-nvim ];

      vim.luaConfigRC = ''local wk = require("which-key")'';

      vim.configRC = ''
        "Settings that are set for everything
        set encoding=utf-8
        set fileencoding=utf-8
        set cursorline
        set autoread
        set so=999
        set noshowmode
        set timeoutlen=1000
        set incsearch
        set wildmenu
        set wildignore+=**/node_modules/**,**/deps/**,**/_build/**
        set smartindent
        set laststatus=2
        set showtabline=0
        set ruler
        set pumheight=10
        set ignorecase
        set smartcase
        set mouse=${cfg.mouseSupport}
        set conceallevel=${toString cfg.concealLevel}
        set tabstop=${toString cfg.tabWidth}
        set shiftwidth=${toString cfg.tabWidth}
        set softtabstop=${toString cfg.tabWidth}
        set expandtab
        set cmdheight=${toString cfg.cmdHeight}
        set updatetime=${toString cfg.updateTime}
        set shortmess+=c
        set tm=${toString cfg.mapTimeout}
        set hidden
        ${writeIf cfg.splitBelow ''
          set splitbelow
        ''}
        ${writeIf cfg.splitRight ''
          set splitright
        ''}
        ${writeIf cfg.showSignColumn ''
          set signcolumn=yes
        ''}
        ${writeIf cfg.autoIndent ''
          set ai
        ''}
        ${writeIf cfg.preventJunkFiles ''
          set noswapfile
          set nobackup
          set nowritebackup
        ''}
        ${writeIf (cfg.bell == "none") ''
          set noerrorbells
          set novisualbell
        ''}
        ${writeIf (cfg.bell == "on") ''
          set novisualbell
        ''}
        ${writeIf (cfg.bell == "visual") ''
          set noerrorbells
        ''}
        ${writeIf (cfg.lineNumberMode == "relative") ''
          set relativenumber
        ''}
        ${writeIf (cfg.lineNumberMode == "number") ''
          set number
        ''}
        ${writeIf (cfg.lineNumberMode == "relNumber") ''
          set number relativenumber
        ''}
        ${writeIf cfg.mapLeaderSpace ''
          let mapleader=" "
          let maplocalleader=","
        ''}
        ${writeIf cfg.syntaxHighlighting ''
          syntax enable
        ''}
        ${writeIf cfg.hlSearch ''
          set hlsearch
        ''}
        ${writeIf cfg.colourTerm ''
          set termguicolors
          set t_Co=256
        ''}

        filetype plugin on
        filetype plugin indent on
        highlight NvimTreeFolderIcon guibg=blue

        au TermOpen term://* setlocal nonumber norelativenumber | setfiletype terminal
      '';
    }
  );
}
