{ pkgs, config, lib, ... }:

let
  inherit (lib) mkEnableOption mkOption mkIf types writeIf withPlugins;
  inherit (builtins) boolToString;
  cfg = config.vim.visuals;
in
{
  options.vim.visuals = {
    enable = mkEnableOption "visual enhancements";

    nvimWebDevicons.enable = mkEnableOption "enable dev icons. required for certain plugins";

    lspkind.enable = mkEnableOption "enable vscode-like pictograms for lsp [lspkind]";

    cursorWordline = {
      enable = mkEnableOption "enable word and delayed line highlight [nvim-cursorline]";

      lineTimeout = mkOption {
        type = types.int;
        description = "time in milliseconds for cursorline to appear";
      };
    };

    indentBlankline = {
      enable = mkEnableOption "enable indentation guides [indent-blankline]";

      listChar = mkOption {
        type = types.str;
        description = "Character for indentation line";
      };

      fillChar = mkOption {
        type = types.str;
        description = "Character to fill indents";
      };

      eolChar = mkOption {
        type = types.str;
        description = "Character at end of line";
      };

      showCurrContext = mkOption {
        type = types.bool;
        description = "Highlight current context from treesitter";
      };
    };
  };

  config = mkIf cfg.enable
    {
      vim.startPlugins = with pkgs.neovimPlugins; (
        (withPlugins cfg.nvimWebDevicons.enable [ nvim-web-devicons ]) ++
        (withPlugins cfg.lspkind.enable [ lspkind ]) ++
        (withPlugins cfg.cursorWordline.enable [ nvim-cursorline ]) ++
        (withPlugins cfg.indentBlankline.enable [ indent-blankline ])
      );

      vim.luaConfigRC = ''
        ${writeIf cfg.lspkind.enable "require'lspkind'.init()"}

        ${writeIf cfg.indentBlankline.enable ''
            -- highlight error: https://github.com/lukas-reineke/indent-blankline.nvim/issues/59
            vim.wo.colorcolumn = "99999"
            vim.opt.list = true

            ${writeIf (cfg.indentBlankline.eolChar != "") ''
                vim.opt.listchars:append({ eol = "${cfg.indentBlankline.eolChar}" })
              ''
            }

            ${writeIf (cfg.indentBlankline.fillChar != "") ''
                vim.opt.listchars:append({ space = "${cfg.indentBlankline.fillChar}"})
              ''
            }

            require("indent_blankline").setup {
              char = "${cfg.indentBlankline.listChar}",
              show_current_context = ${boolToString cfg.indentBlankline.showCurrContext},
              show_end_of_line = true,
            }
          ''
        }

        ${writeIf cfg.cursorWordline.enable ''
            vim.g.cursorline_timeout = ${toString cfg.cursorWordline.lineTimeout}
          ''
        }
      '';
    };
}
