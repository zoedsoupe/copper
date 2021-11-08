{ pkgs, lib, config, ... }:

let
  inherit (pkgs) neovimPlugins;
in
{
  config = {
    vim.startPlugins = with neovimPlugins; [
      telescope-nvim
      popup-nvim
      plenary-nvim
    ];

    vim.nnoremap = {
      "<leader>ff" = ":Telescope find_files<cr>";
      "<leader>fg" = ":Telescope live_grep<cr>";
      "<leader>fb" = ":Telescope buffers<cr>";
    };

    vim.luaConfigRC = ''
      local wk = require("which-key")

      wk.register({
        f = {
          name = "Buffers",
          f = { "Find File" },
          g = { "Grep" },
          b = { "List Buffers"  },
        },
      }, { prefix = "<leader>" })
    '';
  };
}
