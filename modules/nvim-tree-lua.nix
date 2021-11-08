{ pkgs, lib, config, ... }:

let
  inherit (pkgs) neovimPlugins;
  inherit (lib) mkOption mkEnableOption;
  inherit (lib.types) listOf str int bool enum attrs;
  cfg = config.vim.nvimTreeLua;
in
{
  options.vim.nvimTreeLua = {
    enable = mkEnableOption "Enable nvim-tree-lua";

    treeSide = mkOption {
      default = "left";
      description = "Side the tree will appear on left or right";
      type = enum ["left" "right"];
    };

    treeWidth = mkOption {
      default = 30;
      description = "Width of the tree in charecters";
      type = int;
    };

    hideFiles = mkOption {
      default = [
        ".git"
        "node_modules"
        ".cache"
        "deps"
        "_build"
        ".nix-hex"
        ".nix-mix"
        ".postgres"
      ];
      description = "Files to hide in the file view by default";
      type = listOf str;
    };

    hideIgnoredGitFiles = mkOption {
      default = true;
      description = "Hide files ignored by git";
      type = bool;
    };

    openOnDirectoryStart = mkOption {
      default = true;
      description = "Open when vim is started on a directory";
      type = bool;
    };

    closeOnLastWindow = mkOption {
      default = true;
      description = "Close when tree is last window open";
      type = bool;
    };

    ignoreFileTypes = mkOption {
      default = [ "startify" "dashboard" ];
      description = "Ignore file types";
      type = listOf str;
    };

    closeOnFileOpen = mkOption {
      default = true;
      description = "Close the tree when a file is opened";
      type = bool;
    };

    followBufferFile = mkOption {
      default = true;
      description = "Follow file that is in current buffer on tree";
      type = bool;
    };

    indentMarkers = mkOption {
      default = true;
      description = "Show indent markers";
      type = bool;
    };

    hideDotFiles = mkOption {
      default = false;
      description = "Hide dotfiles";
      type = bool;
    };

    openTreeOnNewTab = mkOption {
      default = false;
      description = "Opens the tree view when opening a new tab";
      type = bool;
    };

    disableNetRW = mkOption {
      default = true;
      description = "Disables netrw and replaces it with tree";
      type = bool;
    };

    trailingSlash = mkOption {
      default = true;
      description = "Add a trailing slash to all folders";
      type = bool;
    };

    groupEmptyFolders = mkOption {
      default = true;
      description = "Compat empty folders trees into a single item";
      type = bool;
    };

    showIcons = mkOption {
      default = { git = true; folders = false; files = true; folder_arrows = true; };
      description = "Which icons to show up";
      type = attrs;
    };
  };

  config = 
  (let
    mkVimBool =  val: if val then 1 else 0;
  in {
    vim.startPlugins = with neovimPlugins; [
      nvim-tree-lua
      nvim-web-devicons
    ];

    vim.nnoremap = {
      "<c-n>" = ":NvimTreeToggle<cr>";
      "<leader>n" = ":NvimTreeFindFile<cr>";
    };

    vim.globals = {
      "nvim_tree_ignore" = cfg.hideFiles;
      "nvim_tree_gitignore" = mkVimBool cfg.hideIgnoredGitFiles;
      "nvim_tree_quit_on_open" = mkVimBool cfg.closeOnFileOpen;
      "nvim_tree_indent_markers" = mkVimBool cfg.indentMarkers;
      "nvim_tree_hide_dotfiles" = mkVimBool cfg.hideDotFiles;
      "nvim_tree_add_trailing" = mkVimBool cfg.trailingSlash;
      "nvim_tree_group_empty" = mkVimBool cfg.groupEmptyFolders;

      "nvim_tree_show_icons_git" = mkVimBool cfg.showIcons.git;
      "nvim_tree_show_icons_folders" = mkVimBool cfg.showIcons.folders;
      "nvim_tree_show_icons_files" = mkVimBool cfg.showIcons.files;
      "nvim_tree_show_icons_folder_arros" = mkVimBool cfg.showIcons.folder_arrows;

      "nvim_tree_icons_default" = "";
      "nvim_tree_icons_symlink" = "";
      "nvim_tree_icons_git_unstaged" = "";
      "nvim_tree_icons_git_staged" = "S";
      "nvim_tree_icons_git_unmerged" = "";
      "nvim_tree_icons_git_renamed" =  "➜";
      "nvim_tree_icons_git_deleted" =  "";
      "nvim_tree_icons_git_untracked" =  "U";
      "nvim_tree_icons_git_ignored" =  "◌";
    };

    vim.luaConfigRC = ''
      local wk = require("which-key")

      wk.register({
        ['C-n'] = { "Toggle Tree" },
        ['<leader>n'] = { "Find File" },
      })
    '';
  });
}
