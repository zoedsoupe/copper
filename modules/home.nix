{ pkgs, nvimConfig, lib, hmArgs, ... }:

with lib;

let
  inherit (hmArgs) username stateVersion homeDirectory;
  cfg = nvimConfig.vim.lsp;
in
mkIf (cfg.autocomplete.enable) {
  home = {
    inherit username stateVersion homeDirectory;
    packages = [ pkgs.solargraph ];
  };

  xdg.configFile."nvim/coc-settings.json".source = pkgs.writeTextFile {
    name = "coc-settings.json";
    text = builtins.toJSON {
      "codeLens.enable" = true;
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
          "command" = "${pkgs.rust-analyzer}/bin/rust-analyzer";
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
