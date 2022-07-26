{ pkgs, config, lib, ... }:

let
  inherit (lib) mkEnableOption mkIf;

  writeIf = cond: msg:
    if cond
    then msg
    else "";

  cfg = config.vim.lsp;
in
{
  options.vim.lsp = {
    debugger = {
      enable = mkEnableOption "Nvim Dap";
      elixir = mkEnableOption "Elixir debugger";
    };
  };

  config = mkIf cfg.debugger.enable {
    vim.startPlugins = with pkgs.neovimPlugins; [
      nvim-dap
      nvim-dap-ui
    ];

    vim.nnoremap = {
      "<leader>ldb" = "<cmd>lua require'dap'.toggle_breakpoint()";
      "<leader>ldc" = "<cmd>lua require'dap'.continue()";
      "<leader>lds" = "<cmd>lua require'dap'.step_into()";
      "<leader>ldr" = "<cmd>lua require'dap'.repl.open()";
    };

    vim.luaConfigRC = ''
      local dap, dapui = require("dap"), require("dapui")

      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end

      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end

      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      ${writeIf cfg.debugger.elixir
      ''
      dap.adapters.mix_task = {
        type = 'executable',
        command = '${pkgs.elixir_ls}/lib/debugger.sh',
        args = {}
      }

      dap.configurations.elixir = {
        {
          type = "mix_task",
          name = "mix test",
          task = 'test',
          taskArgs = {"--trace"},
          request = "launch",
          startApps = true, -- for Phoenix projects
          projectDir = "''${workspaceFolder}",
          requireFiles = {
            "test/**/test_helper.exs",
            "test/**/*_test.exs"
          }
        },
      }
      ''}

      require("dapui").setup({
        icons = { expanded = "▾", collapsed = "▸" },
        mappings = {
          -- Use a table to apply multiple mappings
          expand = { "<CR>", "<2-LeftMouse>" },
          open = "o",
          remove = "d",
          edit = "e",
          repl = "r",
          toggle = "t",
        },
        expand_lines = true,
        layouts = {
          {
            elements = {
              { id = "scopes", size = 0.25 },
              "breakpoints",
              "stacks",
              "watches",
            },
            size = 40, -- 40 columns
            position = "left",
          },
          {
            elements = {
              "repl",
              "console",
            },
            size = 0.25, -- 25% of total lines
            position = "bottom",
          },
        },
        floating = {
          max_height = 0.4,
          max_width = 0.5,
          border = "single",
          mappings = {
            close = { "q", "<Esc>" },
          },
        },
        windows = { indent = 1 },
        render = {
          max_type_length = nil, -- Can be integer or nil.
        }
      })
    '';
  };
}
