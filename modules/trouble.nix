{ pkgs, lib, config, ... }:

let
  inherit (pkgs) neovimPlugins;
  inherit (lib) mkEnableOption mkOption;
  inherit (lib.types) enum str int bool attrsOf;

  cfg = config.vim.trouble;
in
{
  options.vim.trouble = {
    enable = mkEnableOption "Enable trouble list";

    position = mkOption {
      default = "bottom";
      description = "Position of the list";
      type = enum [ "bottom" "top" "left" "right" ];
    };

    dimensions = mkOption {
      default = { height = 10; width = 50; };
      description = "Height and width of the list";
      type = attrsOf int;
    };

    icons = mkOption {
      default = true;
      description = "Enable list icons";
      type = bool;
    };
  };

  config = {
    vim.startPlugins = with neovimPlugins; [ trouble ];

    vim.luaConfigRC = ''
require("trouble").setup{
    position = ${cfg.position},
    height = ${toString cfg.dimensions.height},
    width = ${toString cfg.dimensions.width},
    icons = ${toString cfg.icons},
    mode = "lsp_workspace_diagnostics",
    fold_open = "",
    fold_closed = "",
    group = true,
    padding = true,
    action_keys = { -- key mappings for actions in the trouble list
        -- map to {} to remove a mapping, for example:
        -- close = {},
        close = "q", -- close the list
        cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
        refresh = "r", -- manually refresh
        jump = {"<cr>", "<tab>"}, -- jump to the diagnostic or open / close folds
        open_split = { "<c-x>" }, -- open buffer in new split
        open_vsplit = { "<c-v>" }, -- open buffer in new vsplit
        open_tab = { "<c-t>" }, -- open buffer in new tab
        jump_close = {"o"}, -- jump to the diagnostic and close the list
        toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
        toggle_preview = "P", -- toggle auto_preview
        hover = "K", -- opens a small popup with the full multiline message
        preview = "p", -- preview the diagnostic location
        close_folds = {"zM", "zm"}, -- close all folds
        open_folds = {"zR", "zr"}, -- open all folds
        toggle_fold = {"zA", "za"}, -- toggle fold of current file
        previous = "k", -- preview item
        next = "j" -- next item
    },
    indent_lines = true, -- add an indent guide below the fold icons
    auto_open = false, -- automatically open the list when you have diagnostics
    auto_close = false, -- automatically close the list when you have no diagnostics
    auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
    auto_fold = false, -- automatically fold a file trouble list at creation
    auto_jump = {"lsp_definitions"}, -- for the given modes, automatically jump if there is only a single result
    signs = {
        -- icons / text used for a diagnostic
        error = "",
        warning = "",
        hint = "",
        information = "",
        other = "﫠"
    },
    use_lsp_diagnostic_signs = false -- enabling this will use the signs defined in your lsp client
}
    '';
  };
}
