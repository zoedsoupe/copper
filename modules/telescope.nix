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
      telescope-ui-select
    ];

    vim.nnoremap = {
      "<leader>ff" = ":Telescope find_files<cr>";
      "<leader>fg" = ":Telescope live_grep<cr>";
      "<leader>fb" = ":Telescope buffers<cr>";
      "<leader>fs" = "<cmd> Telescope treesitter<CR>";

      "<leader>fvcw" = "<cmd> Telescope git_commits<CR>";
      "<leader>fvcb" = "<cmd> Telescope git_bcommits<CR>";
      "<leader>fvb" = "<cmd> Telescope git_branches<CR>";
      "<leader>fvs" = "<cmd> Telescope git_status<CR>";
      "<leader>fvx" = "<cmd> Telescope git_stash<CR>";
    };

    vim.luaConfigRC = ''
      require("telescope").setup{
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown{}
          },
        },
        pickers = {
          find_command = {
            "${pkgs.fd}/bin/fd",
          },
        },
        defaults = {
          vimgrep_arguments = {
            "${pkgs.ripgrep}/bin/rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--trim" -- add this value
          }
        }
      }

      require("telescope").load_extension("ui-select")

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
