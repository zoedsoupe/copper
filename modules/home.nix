{ pkgs, config, lib, ... }:

with lib;

mkIf (config.autocomplete.enable) {
  home.packages = [ pkgs.solargraph ];

  xdg.configFile."nvim/coc-settings.json".source = pkgs.writeTextFile {
    name = "coc-settings.json";
    text = builtins.toJSON {
      "codeLens.enable" = true;
      "rust-client" = {
        "disableRustup" = true;
        "rlsPath" = "${pkgs.rls}/bin/rls";
      };
      "suggest" = {
        "noselect" = true;
        "removeDuplicateItems" = true;
      };
      "languageserver" = {
        "elixirLS" = {
          "command" = "${pkgs.elixir_ls}/bin/elixir-ls";
          "filetypes" = [ "elixir" "eexlixir" "heexlixir" ];
        };
        "rust" = {
          "command" = "${pkgs.rls}/bin/rls";
          "rootPatterns" = [ "Cargo.toml" ];
          "filetypes" = [ "rs" ];
        };
        "rescript" = {
          "enable" = true;
          "module" = "${pkgs.neovimPlugins.vim-rescript}/server/out/server.js";
          "args" = [ "--node-ipc" ];
          "filetypes" = [ "rescript" ];
          "rootPatterns" = [ "bsconfig.json" ];
        };
        "nix" = { "command" = "${pkgs.rnix-lsp}/bin/rnix-lsp"; "filetypes" = [ "nix" ]; };
        # FIX ME (coc-solargraph needs binary to be on $PATH)
        # "solargraph" = {
        #   "commandPath" = "${pkgs.solargraph}/bin";
        #   "filetypes" = [ "rb" "erb" ];
        # };
      };
      "coc.preferences" = {
        "useQuickfixForLocations" = true;
        "snippets.enable" = true;
        "extensionsUpdateCheck" = "never";
        "formatOnSaveFiletypes" = [
          "elixir"
          "rust"
          "nix"
        ];
      };
    };
  };
}
