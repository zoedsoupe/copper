{ pkgs, ... }:

with pkgs; with vimUtils;

{
  vim-rescript = buildVimPluginFrom2Nix {
    name = "vim-rescript";
    src = fetchFromGitHub {
      owner = "rescript-lang";
      repo = "vim-rescript";
      rev = "HEAD";
      sha256 = "1qzf1g00abj658nvp45nkzjwwdwhbhswpdndrwzsf7y3h2knjlx0";
    };
  };

  bullets-vim = buildVimPluginFrom2Nix {
    name = "bullets-vim";
    src = fetchFromGitHub {
      owner = "dkarter";
      repo = "bullets.vim";
      rev = "HEAD";
      sha256 = "14zbvl0wzbg1a35hya6ii31mamsmmzzwl6lfs4l6vmiz377k06gg";
    };
  };

  orgmode = buildVimPluginFrom2Nix {
    name = "orgmode";
    src = fetchFromGitHub {
      owner = "kristijanhusak";
      repo = "orgmode.nvim";
      rev = "HEAD";
      sha256 = "0rfa8cpykarcal8qcfp1dax1kgcbq7bv1ld6r1ia08n9vnqi5vm6";
    };
  };

  nvim-comment = buildVimPluginFrom2Nix {
    name = "nvim-comment";
    src = fetchFromGitHub {
      owner = "terrortylor";
      repo = "nvim-comment";
      rev = "HEAD";
      sha256 = "wv4scKfo4EyHLnP7zOHOhQ4Z7ok8lOvB/NS4RpX9Lg0=";
    };
  };

  neoscroll = buildVimPluginFrom2Nix {
    name = "neoscroll";
    src = fetchFromGitHub {
      owner = "karb94";
      repo = "neoscroll.nvim";
      rev = "HEAD";
      sha256 = "TIuw6ACyTQDHD2JfnqJA/hmSLVZnxYMjZNMKiMXqrWQ=";
    };
  };

  true-zen = buildVimPluginFrom2Nix {
    name = "true-zen";
    src = fetchFromGitHub {
      owner = "Pocco81";
      repo = "TrueZen.nvim";
      rev = "HEAD";
      sha256 = "y40nIQKbQpSSfGjav73WKw/fRxPFTSVpMXYgEVs+8wA=";
    };
  };

  telescope-media = buildVimPluginFrom2Nix {
    name = "telescope-media";
    src = fetchFromGitHub {
      owner = "nvim-telescope";
      repo = "/telescope-media-files.nvim";
      rev = "HEAD";
      sha256 = "h66JIgRi693WAfIk3CRJTsIAX1/V28EJHwo+5dTRuJ8=";
    };
  };

  nvim-base16 = buildVimPluginFrom2Nix {
    name = "nvim-base16";
    namePrefix = "";
    src = fetchFromGitHub {
      owner = "NvChad";
      repo = "nvim-base16.lua";
      rev = "HEAD";
      sha256 = "7CZlBDEj+OckjzB+2V+/ydrht1CFcP2BrNfTjgDYTg0=";
    };
  };
}
