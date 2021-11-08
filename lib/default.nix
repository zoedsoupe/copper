{ pkgs, inputs, plugins, ...}:

{
  inherit (pkgs.lib);

  neovimWrapper = import ./neovimBuilder.nix { inherit pkgs; };
  buildPluginOverlay = import ./buildPlugin.nix { inherit inputs plugins;}; 
}
