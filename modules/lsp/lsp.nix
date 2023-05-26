{ pkgs, config, lib, ... }:

let
  inherit (lib) mkEnableOption mkOption mkIf types writeIf withPlugins;
  cfg = config.vim.lsp;
in
{
  options.vim.lsp = {
    enable = mkEnableOption "neovim lsp support";
    folds = mkEnableOption "Folds via nvim-ufo";
    formatOnSave = mkEnableOption "Format on save";
    nix = {
      enable = mkEnableOption "Nix LSP";
      type = mkOption {
        type = types.enum [ "nil" "rnix-lsp" ];
        default = "rnix-lsp";
        description = "Whether to use `nil` or `rnix-lsp`";
      };
    };
    dart = mkEnableOption "Dart LSP";
    ts = mkEnableOption "TS language LSP";
    elixir = mkEnableOption "Elixir language LSP";
    clojure = mkEnableOption "Clojure language LSP";
    lua = mkEnableOption "Lua language LSP";
    rust = {
      enable = mkEnableOption "Rust LSP";
      rustAnalyzerOpts = mkOption {
        type = types.str;
        default = ''
          ["rust-analyzer"] = {
            experimental = {
              procAttrMacros = true,
            },
          },
        '';
        description = "options to pass to rust analyzer";
      };
    };
  };

  config = mkIf cfg.enable {
    vim.startPlugins = with pkgs.neovimPlugins;
      [ nvim-lspconfig null-ls ] ++
      (withPlugins (config.vim.autocomplete.enable) [ cmp-nvim-lsp ]) ++
      (withPlugins cfg.folds [ promise-async nvim-ufo ]) ++
      (withPlugins cfg.rust.enable [ rust-tools ]) ++
      (withPlugins cfg.ts [ typescript-nvim ]) ++
      (withPlugins cfg.clojure [ conjure vim-sexp vim-sexp-mappings ]);

    vim.configRC = ''
      ${writeIf cfg.rust.enable ''
          function! MapRustTools()
            nnoremap <silent><leader>ri <cmd>lua require('rust-tools.inlay_hints').toggle_inlay_hints()<CR>
            nnoremap <silent><leader>rr <cmd>lua require('rust-tools.runnables').runnables()<CR>
            nnoremap <silent><leader>re <cmd>lua require('rust-tools.expand_macro').expand_macro()<CR>
            nnoremap <silent><leader>rc <cmd>lua require('rust-tools.open_cargo_toml').open_cargo_toml()<CR>
            nnoremap <silent><leader>rg <cmd>lua require('rust-tools.crate_graph').view_crate_graph('x11', nil)<CR>
          endfunction

          autocmd filetype rust nnoremap <silent><leader>ri <cmd>lua require('rust-tools.inlay_hints').toggle_inlay_hints()<CR>
          autocmd filetype rust nnoremap <silent><leader>rr <cmd>lua require('rust-tools.runnables').runnables()<CR>
          autocmd filetype rust nnoremap <silent><leader>re <cmd>lua require('rust-tools.expand_macro').expand_macro()<CR>
          autocmd filetype rust nnoremap <silent><leader>rc <cmd>lua require('rust-tools.open_cargo_toml').open_cargo_toml()<CR>
          autocmd filetype rust nnoremap <silent><leader>rg <cmd>lua require('rust-tools.crate_graph').view_crate_graph('x11', nil)<CR>
        ''
      }

      ${writeIf cfg.nix.enable ''
          autocmd filetype nix setlocal tabstop=2 shiftwidth=2 softtabstop=2
        ''
      }
    '';

    vim.luaConfigRC = ''
        local attach_keymaps = function(client, bufnr)
          local opts = { noremap=true, silent=true }

          vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lgD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
          vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lgd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
          vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lgt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
          vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lgn', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
          vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lgp', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
      
          -- Alternative keybinding for code actions for when code-action-menu does not work as expected.
          vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)

          vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lwa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
          vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lwr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
          vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lwl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)

          vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lh', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
          vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ls', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
          vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ln', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
          vim.api.nvim_buf_set_keymap(bufnr, 'n', 'F', '<cmd>lua vim.lsp.buf.format { async = true }<CR>', opts)
        end

        local null_ls = require("null-ls")
        local null_helpers = require("null-ls.helpers")
        local null_methods = require("null-ls.methods")

        local ls_sources = {
          ${writeIf cfg.ts
        ''
            null_ls.builtins.diagnostics.eslint,
            null_ls.builtins.formatting.prettier,
          ''}
        }

        vim.g.formatsave = ${
          if cfg.formatOnSave
          then "true"
          else "false"
        };

        -- Enable formatting
        format_callback = function(client, bufnr)
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

        default_on_attach = function(client, bufnr)
          attach_keymaps(client, bufnr)
          format_callback(client, bufnr)
        end

        -- Enable null-ls
        require('null-ls').setup({
          diagnostics_format = "[#{m}] #{s} (#{c})",
          debounce = 250,
          default_timeout = 5000,
          sources = ls_sources,
          on_attach=default_on_attach
        })

        -- Enable lspconfig
        local lspconfig = require('lspconfig')

        local capabilities = vim.lsp.protocol.make_client_capabilities()

        ${writeIf cfg.folds ''
          capabilities.textDocument.foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true
          }

          -- Display number of folded lines
          local ufo_handler = function(virtText, lnum, endLnum, width, truncate)
            local newVirtText = {}
            local suffix = ('  %d '):format(endLnum - lnum)
            local sufWidth = vim.fn.strdisplaywidth(suffix)
            local targetWidth = width - sufWidth
            local curWidth = 0
            for _, chunk in ipairs(virtText) do
              local chunkText = chunk[1]
              local chunkWidth = vim.fn.strdisplaywidth(chunkText)
              if targetWidth > curWidth + chunkWidth then
                table.insert(newVirtText, chunk)
              else
                  chunkText = truncate(chunkText, targetWidth - curWidth)
                  local hlGroup = chunk[2]
                  table.insert(newVirtText, {chunkText, hlGroup})
                  chunkWidth = vim.fn.strdisplaywidth(chunkText)
                  -- str width returned from truncate() may less than 2nd argument, need padding
                  if curWidth + chunkWidth < targetWidth then
                    suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
                  end
                  break
              end
              curWidth = curWidth + chunkWidth
            end
            table.insert(newVirtText, {suffix, 'MoreMsg'})
            return newVirtText
          end

          require('ufo').setup({
             fold_virt_text_handler = ufo_handler
          })

          -- Using ufo provider needs a large value
          vim.o.foldlevel = 99 
          vim.o.foldlevelstart = 99
          vim.o.foldenable = true

          -- Using ufo provider need remap `zR` and `zM`
          vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
          vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
          vim.keymap.set('n', 'zr', require('ufo').openFoldsExceptKinds)
          vim.keymap.set('n', 'zm', require('ufo').closeFoldsWith)
        ''}

        ${let
          cfg = config.vim.autocomplete;
        in
          writeIf cfg.enable ''
              capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
            ''
          }

        ${writeIf cfg.rust.enable ''
          -- Rust config

          local rustopts = {
            tools = {
              autoSetHints = true,
              hover_with_actions = false,
              inlay_hints = {
                only_current_line = false,
              }
            },
            server = {
              capabilities = capabilities,
              on_attach = default_on_attach,
              cmd = {"${pkgs.rust-analyzer}/bin/rust-analyzer"},
              settings = {
                ${cfg.rust.rustAnalyzerOpts}
              }
            }
          }

          require('rust-tools').setup(rustopts)
        ''}

        ${writeIf (cfg.nix.enable && cfg.nix.type == "nil") ''
          -- Nix config
          lspconfig.nil_ls.setup{
            capabilities = capabilities;
            on_attach = function(client, bufnr)
              attach_keymaps(client, bufnr)
            end,
            settings = {
              ['nil'] = {
                formatting = {
                  command = {"${pkgs.nixpkgs-fmt}/bin/nixpkgs-fmt"}
                },
                diagnostics = {
                  ignored = { "uri_literal" },
                  excludedFiles = { }
                }
              }
            };
            cmd = {"${pkgs.nil}/bin/nil"}
          }
        ''}

        ${writeIf (cfg.nix.enable && cfg.nix.type == "rnix-lsp") ''
          -- Nix config
          lspconfig.rnix.setup{
            capabilities = capabilities;
            on_attach = function(client, bufnr)
              attach_keymaps(client, bufnr)
            end,
            cmd = {"${pkgs.rnix-lsp}/bin/rnix-lsp"}
          }
        ''}

        ${writeIf cfg.nix.enable
      ''
          -- Nix formatter
          null_ls.builtins.formatting.alejandra.with({
            command = "${pkgs.nixpkgs-fmt}/bin/nixpkgs-fmt";
          });
        ''}

        ${writeIf cfg.elixir ''
        -- Elixir config
        lspconfig.elixirls.setup {
          capabilities = capabilities;
          on_attach = function(client, bufnr)
            attach_keymaps(client, bufnr)
          end,
          cmd = {"${pkgs.elixir_ls}/bin/elixir-ls"}
        }
        ''}

        ${writeIf cfg.clojure ''
        -- Clojure config
        lspconfig.clojure_lsp.setup {
          capabilities = capabilities;
          on_attach = function(client, bufnr)
            attach_keymaps(client, bufnr)
          end,
          cmd = {"${pkgs.clojure-lsp}/bin/clojure-lsp"}
        }
        ''}

        ${writeIf cfg.dart ''
        -- Dart config
        lspconfig.dartls.setup {
          capabilities = capabilities;
          on_attach = function(client, bufnr)
            attach_keymaps(client, bufnr)
          end,
          cmd = {"${pkgs.dart}/bin/dart", "language-server", "--protocol=lsp"}
        }
        ''}

        ${writeIf cfg.ts ''
          -- TS config
          require("typescript").setup({
            server = {
              capabilities = capabilities;
              on_attach = function(client, bufnr)
                attach_keymaps(client, bufnr)
              end,
              cmd = { "${pkgs.nodePackages.typescript-language-server}/bin/typescript-language-server", "--stdio" }
            }
          })
        ''}
    '';
  };
}
