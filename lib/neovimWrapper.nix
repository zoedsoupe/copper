{ pkgs, lib ? pkgs.lib, ... }:

{ config }:
let
  inherit (pkgs) neovimPlugins wrapNeovim fetchFromGitHub;

  vimOptions = lib.evalModules {
    modules = [
      { imports = [../modules]; }
      config 
    ];

    specialArgs = {
      inherit pkgs; 
    };
  };

  vim = vimOptions.config.vim;

  custom-neovim = pkgs.neovim-unwrapped.overrideAttrs (old: rec {
    version = "0.5.1";
    src = fetchFromGitHub {
      owner = "neovim";
      repo = "neovim";
      rev = "v${version}";
      sha256 = "07PrR7KElLJhzS/4Z8lLiWuOehx4npyh4puSAJNqTyw=";
    };
    cmakeFlags = old.cmakeFlags ++ ([ "-DUSE)BUNDLED=OFF" ]);
    buildInputs = old.buildInputs ++ (with pkgs; [
      # nvim-treesitter packages
      gcc
      tree-sitter
    ]);
  });
in wrapNeovim custom-neovim {
  viAlias = true;
  vimAlias = true;
  withNodeJs = true;
  withPython3 = true;
  configure = {
    customRC = vim.configRC;
    packages.myVimPackage = with pkgs.vimPlugins; {
      start = vim.startPlugins;
      opt = vim.optPlugins;
    };
  };
}
