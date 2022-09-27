{ pkgs, lib, config, ... }:

let
  inherit (pkgs) neovimPlugins;
  inherit (lib) mkEnableOption mkOption mkIf types;
  inherit (types) enum str;

  cfg = config.vim.theme;
in
{
  options.vim.theme = {
    enable = mkEnableOption "Enable Themes config";

    name = mkOption {
      default = "material";
      description = "Sets the current theme";
      type = enum [ "material" "omni" "boo" "melange" "doom-one" "rose-pine" ];
    };

    style = mkOption {
      description = "Sets theme style";
      default = "palenight";
      type = str;
    };
  };

  config = mkIf cfg.enable {
    vim.startPlugins = with neovimPlugins;  [
      material-nvim
      omni
      boo
      melange
      doom-one
      rose-pine
    ];

    vim.luaConfigRC =
      if cfg.name == "material" then ''
        vim.g.material_style = "${cfg.style}"
        require('material').setup({
          italics = {
            comments = true,
          },
        })
        vim.cmd[[colorscheme material]]
      '' else if cfg.name == "boo" then ''
        require("boo-colorscheme").use({
          theme = ${cfg.style},
        })
      '' else if cfg.name == "doom-one" then ''
        require("doom-one").setup({
          italic_comments = true,
          enable_treesitter = true,
          plugins_integrations = {
            bufferline = true,
            gitsigns = true,
            telescope = true,
            nvim_tree = true,
            dashboard = true,
            whichkey = true,
            indent_blankline = true,
            lspsaga = true
          },
        })
      '' else if cfg.name == "rose-pine" then ''
        require("rose-pine").setup()
        vim.cmd[[colorscheme rose-pine]]
      '' else "vim.cmd[[colorscheme ${cfg.name}]]";
  };
}
