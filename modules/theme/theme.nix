{ pkgs, config, lib, ... }:

with lib;
with builtins;

let
  cfg = config.vim.theme;

  enum' = name: flavors: other:
    if (cfg.name == name) then types.enum flavors else other;
in
{
  options.vim.theme = {
    enable = mkOption {
      type = types.bool;
      description = "Enable Theme";
    };

    name = mkOption {
      type = types.enum [ "doom-one" "rose-pine" "catppuccin" ];
      default = "rose-pine";
      description = "Name of theme to use";
    };

    style = mkOption {
      type =
        let
          rp = enum' "rose-pine" [ "main" "moon" "dawn" ];
          cp = types.enum [ "frappe" "latte" "macchiato" "mocha" ];
        in
        rp cp;
      description = "Theme style";
    };

    transparency = mkOption {
      type = types.bool;
      default = false;
      description = "Background transparency";
    };
  };

  config = mkIf cfg.enable (
    let
      transparency = builtins.toString cfg.transparency;
    in
    {
      vim.startPlugins = with pkgs.neovimPlugins; (
        (withPlugins (cfg.name == "rose-pine") [ rosepine ]) ++
        (withPlugins (cfg.name == "catppuccin") [ catppuccin ])
      );

      # for catppuccin I'm trying to automate
      # the change of colorscheme
      # based on system theme or system time
      vim.luaConfigRC = ''
      ${writeIf (cfg.name == "catppuccin") ''
      vim.g.catppuccin_flavour = "${cfg.style}"
      require("catppuccin").setup({
        flavour = "${cfg.style}",
        background = {
          light = "latte",
          dark = "${cfg.style}"
        },
        transparent_background = ${if cfg.transparency then "true" else "false"},
      })
      vim.cmd("colo catppuccin")
      ''}

      ${writeIf (cfg.name == "doom-one") ''
      vim.g.doom_one_terminal_colors = true
      vim.g.doom_one_plugin_whichkey = true
      vim.g.doom_one_plugin_indent_blankline = true
      vim.g.doom_one_plugin_nvim_tree = true
      vim.g.doom_one_plugin_dashboard = true
      vim.g.doom_one_plugin_telescope = true

      vim.cmd("colorscheme doom-one")
      ''}

      ${writeIf (cfg.name == "rose-pine") ''
      -- Rose Pine theme
      require('rose-pine').setup {
        darkvariant = "${cfg.style}",
        dim_nc_background = "${transparency}",
      }
      vim.cmd [[colorscheme rose-pine]]
      ''}
      '';
    }
    );
  }
