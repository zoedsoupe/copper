{ pkgs, inputs, ... }:

let
  inherit (pkgs.lib) evalModules;
in
{

  mkNeovim = { config }:
    let
      plugins = pkgs.neovimPlugins;

      vimOpts = evalModules {
        modules = [
          { imports = [ ./modules ]; }
          config
        ];

        specialArgs = {
          inherit pkgs;
        };
      };

      vim = vimOpts.config.vim;
    in
    pkgs.wrapNeovim pkgs.neovim-unwrapped {
      inherit (vim) viAlias vimAlias;

      withNodeJs = true;
      withPython3 = true;
      configure = {
        customRC = vim.configRC;
        packages.myVimPackage = with plugins; {
          start = builtins.filter (f: f != null) vim.startPlugins;
          opt = vim.optPlugins;
        };
      };
    };

  buildPluginOverlay = super: self:
    let
      inherit (builtins) attrNames filter listToAttrs;
      inherit (self.vimUtils) buildVimPluginFrom2Nix;

      treesitterGrammars = self.tree-sitter.withPlugins (p: with p; [
        tree-sitter-bash
        tree-sitter-c
        tree-sitter-commonlisp
        tree-sitter-css
        tree-sitter-dockerfile
        tree-sitter-elisp
        tree-sitter-elixir
        tree-sitter-erlang
        tree-sitter-fish
        tree-sitter-haskell
        tree-sitter-html
        tree-sitter-javascript
        tree-sitter-json
        tree-sitter-latex
        tree-sitter-lua
        tree-sitter-nix
        tree-sitter-python
        tree-sitter-rust
        tree-sitter-toml
        tree-sitter-typescript
        tree-sitter-vue
        tree-sitter-yaml
      ]);

      buildPlug = name: buildVimPluginFrom2Nix {
        pname = name;
        version = "HEAD";
        src = builtins.getAttr name inputs;
        postPatch =
          if (name == "nvim-treesitter")
          then ''
            rm -r parser
            ln -s ${treesitterGrammars} parser
          ''
          else "";
      };

      isPlugin = n: n != "neovim" && n != "nixpkgs";

      plugins = filter isPlugin (attrNames inputs);
    in
    {
      neovimPlugins = listToAttrs
        (map
          (name: {
            inherit name;
            value = buildPlug name;
          })
          plugins);
    };
}
