{ pkgs, config, lib, ... }:

{
  imports = [
    ./lsp.nix
    ./lsp-saga.nix
    ./nvim-code-action-menu.nix
    ./trouble.nix
  ];
}
