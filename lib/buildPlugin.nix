{ inputs, plugins, ...}:

final: prev:
let
  inherit (prev.vimUtils) buildVimPluginFrom2Nix;

  buildPlug = name: buildVimPluginFrom2Nix {
    pname = name;
    version = "main";
    src = builtins.getAttr name inputs;
  };
in 
{
  neovimPlugins = builtins.listToAttrs 
    (map (name: { inherit name; value = buildPlug name; }) plugins);
}
