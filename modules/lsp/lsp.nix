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
        [
          nvim-lspconfig
          null-ls
        ]
        ++ (
          if cfg.autocomplete.enable
          then [ coc-nvim ] ++ (with pkgs.nodePackages; [
            coc-css
            coc-diagnostic
            coc-explorer
            coc-html
            coc-json
            coc-rls
            coc-snippets
            coc-yaml
          ])
          else [ ]
        );

      vim.inoremap = {
        "<silent><expr> <TAB>" = ''
          coc#pum#visible() ? coc#pum#next(1) : CheckBackspace() ? "\<Tab>" : coc#refresh()
        '';
        "<expr><S-TAB>" = "coc#pum#visible() ? coc#pum#prev(1) : \"\\\<C-h>\"";
        "<silent><expr> <CR>" = ''
          coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
        '';
        "<silent><expr> <c-space>" = "coc#refresh()";
      };

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

      vim.configRC = ''
        function! CheckBackspace() abort
          let col = col('.') - 1
          return !col || getline('.')[col - 1]  =~# '\s'
        endfunction

        function! ShowDocumentation()
          if CocAction('hasProvider', 'hover')
            call CocActionAsync('doHover')
          else
            call feedkeys('K', 'in')
          endif
        endfunction

        autocmd CursorHold * silent call CocActionAsync('highlight')
      '';

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
      '';
    }
  );
}
