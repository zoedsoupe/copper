{ ... }:

{
  imports = [
    ./theme.nix
    ./core.nix
    ./basic.nix
    ./galaxyline.nix
    ./git.nix
    ./treesitter.nix
    ./telescope.nix
    ./vim-polyglot.nix
    ./editor.nix
    ./extra-plugins.nix
    ./lsp
    ./bufferline-nvim.nix
  ];
}
