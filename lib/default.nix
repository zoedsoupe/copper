{ pkgs, inputs, plugins, ...}:

{
  inherit (pkgs.lib);

  neovimWrapper = import ./neovimWrapper.nix { inherit pkgs; };
  buildPluginOverlay = import ./buildPlugin.nix { inherit inputs plugins;}; 
}
