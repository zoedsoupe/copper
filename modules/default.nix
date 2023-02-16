{ config, lib, pkgs, ... }:

{
  imports = [
    ./autopairs
    ./basic.nix
    ./comments
    ./completion
    ./core.nix
    ./extra-plugins.nix
    ./filetree
    ./git
    ./keys
    ./lsp
    ./neoclip
    ./neovim
    ./snippets
    ./statusline
    ./surround
    ./tabline
    ./telescope
    ./theme
    ./treesitter.nix
    ./vim-polyglot.nix
    ./visuals
  ];
} 
