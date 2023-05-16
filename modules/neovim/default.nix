{ lib, pkgs, ... }:

let
  inherit (lib) mkOption types;
in
{
  options.vim.neovim.package = mkOption {
    type = types.package;
    default = pkgs.neovim-unwrapped;
    description = "The NeoVim package to use. Default pkgs.neovim-unwrapped.";
    example = "pkgs.neovim-nightly";
  };
}
