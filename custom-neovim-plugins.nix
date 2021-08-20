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

  neoclip = buildVimPluginFrom2Nix {
    name = "neoclip";
    src = fetchFromGitHub {
      owner = "AckslD";
      repo = "nvim-neoclip.lua";
      rev = "HEAD";
      sha256 = "0vlmsss6jisg2xaf4gk4md1a5lsds4jgk1cpxhx74snll274bnyd";
    };
  };

  nvim-comment = buildVimPluginFrom2Nix {
    name = "nvim-comment";
    src = fetchFromGitHub {
      owner = "terrortylor";
      repo = "nvim-comment";
      rev = "HEAD";
      sha256 = "f08b26ed6d9b6a78b24ab33da709e31262a6386946178f145f0acb1208339fd5";
    };
  };

  neoscroll = buildVimPluginFrom2Nix {
    name = "neoscroll";
    src = fetchFromGitHub {
      owner = "karb94";
      repo = "neoscroll.nvim";
      rev = "HEAD";
      sha256 = "f2480201fe36a2733aa08595496f115a30b103ad274858e9b0263bd214b7239e";
    };
  };

  truezen = buildVimPluginFrom2Nix {
    name = "truezen";
    src = fetchFromGitHub {
      owner = "Pocco81";
      repo = "TrueZen.nvim";
      rev = "HEAD";
      sha256 = "3335faeaca18c5c3d2875f4b1a6df1c770a0948856ec6683408a30f98c2ab1e5";
    };
  };

  telescope-media = buildVimPluginFrom2Nix {
    name = "telescope-media";
    src = fetchFromGitHub {
      owner = "nvim-telescope";
      repo = "/telescope-media-files.nvim";
      rev = "HEAD";
      sha256 = "5a00b9c7b1d8c61153cdefd53b711dc9914975df8e2447d93cc82a612b6f8779";
    };
  };
}
