{ pkgs, config, lib, ... }:

with builtins;

let
  inherit (lib) boolToString mkEnableOption mkIf mkOption;

  cfg = config.vim.lsp;
in
{
  options.vim.lsp = {
    enable = mkEnableOption "Neovim lsp support";
    autocomplete.enable = mkEnableOption "Enable autocomplete";
    formatOnSave = mkEnableOption "Format on save";
    nix = mkEnableOption "Nix LSP";
    rust = mkEnableOption "Rust LSP";
    elixir = mkEnableOption "Elixir LSP";
    rescript = mkEnableOption "Rescript LSP";
    ruby = mkEnableOption "Ruby LSP";
    typescript = mkEnableOption "Typescript LSP";
  };

  config = mkIf cfg.enable (
    let
      writeIf = cond: msg:
        if cond
        then msg
        else "";
    in
    {
      vim.startPlugins = with pkgs.neovimPlugins;
        [ nvim-lspconfig ]
        ++ (
          if cfg.autocomplete.enable
          then [
            coq-nvim
            coq-artifacts
          ] else [ ]
        );

      vim.inoremap = { };

      vim.nmap = {
        "<silent> <leader>lgn" = "<Plug>(coc-diagnostic-next)";
        "<silent> <leader>lgp" = "<Plug>(coc-diagnostic-prev)";

        "<silent> <leader>lgd" = "<Plug>(coc-definition)";
        "<silent> <leader>lgD" = "<Plug>(coc-implementation)";
        "<silent> <leader>lgt" = "<Plug>(coc-type-definition)";

        "<silent> <leader>lr" = "<Plug>(coc-rename)";
      };

      vim.nnoremap = {
        "<silent> <leader>lh" = ":call ShowDocumentation()<CR>";
      };

      vim.luaConfigRC = ''
        require("which-key").register({
          l = {
            name = "LSP",
            d = {
              name = "debugger",
              b = { "Toggle breakppoint" },
              c = { "Continue flow" },
              s = { "Step into flow" },
              r = { "Start REPL" }
            },
            g = {
              D = { "Goto declaration" },
              d = { "Goto definition" },
              t = { "Goto type definition" },
              n = { "Goto next diagnostic" },
              p = { "Goto previous diagnostic" },
            },
            h = { "Show Hover" },
            r = { "Rename" },
          }
        }, { prefix = "<leader>" })

        local on_attach = function(client, bufnr)
          local opts = { noremap=true, silent=true }

          vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lgD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
          vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lgd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
          vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lgt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
          vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lgn', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
          vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lgp', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
          vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lwa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
          vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lwr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
          vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lwl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
          vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lh', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
          vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ls', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)

          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
              if vim.g.formatsave then
                  local params = require'vim.lsp.util'.make_formatting_params({})
                  client.request('textDocument/formatting', params, nil, bufnr)
              end
            end
          })
        end

        local coq = require("coq")
        vim.g.coq_settings = { auto_start = "shut-up", xdg = true }

        -- Enable lspconfig
        local lspconfig = require('lspconfig')

        ${writeIf cfg.rust ''
          -- Rust config
          lspconfig.rust_analyzer.setup(coq.lsp_ensure_capabilities{
            on_attach = on_attach,
            cmd = {"${pkgs.rust-analyzer}/bin/rust-analyzer"}
          })
        ''}

        ${writeIf cfg.elixir ''
          -- Elixir config
          lspconfig.elixirls.setup(coq.lsp_ensure_capabilities{
            on_attach = on_attach,
            cmd = {"${pkgs.elixir_ls}/bin/elixir-ls"}
          })
        ''}

        ${writeIf cfg.nix ''
          -- Nix config
          lspconfig.rnix.setup(coq.lsp_ensure_capabilities{
            on_attach = on_attach,
            cmd = {"${pkgs.rnix-lsp}/bin/rnix-lsp"}
          })
        ''}

        ${writeIf cfg.ruby ''
          -- Ruby config
          lspconfig.solargraph.setup(coq.lsp_ensure_capabilities{
            on_attach = on_attach,
            cmd = {"${pkgs.solargraph}/bin/solargraph"}
          })
        ''}

        ${writeIf cfg.typescript ''
          -- Typescript config
          lspconfig.tsserver.setup(coq.lsp_ensure_capabilities{
            on_attach = on_attach,
            cmd = {"${pkgs.nodePackages.typescript-language-server}/bin/typescript-language-server"}
          })

          -- Vue config
          lspconfig.vuels.setup(coq.lsp_ensure_capabilities{
            on_attach = on_attach,
            cmd = {"${pkgs.nodePackages.vls}/bin/vls"}
          })
        ''}

        ${writeIf cfg.rescript ''
          -- Rescript config
          lspconfig.tsserver.setup(coq.lsp_ensure_capabilities{
            on_attach = on_attach,
            cmd = {
              "${pkgs.nodejs}/bin/node",
              "${pkgs.neovimPlugins.vim-rescript}/server/out/server.js",
              "--stdio"
            }
          })
        ''}
      '';
    }
  );
}
