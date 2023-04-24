{ system, inputs, lib }:

let
  rnix-lsp = {
    overlay = (super: self: {
      rnix-lsp = inputs.rnix-lsp.defaultPackage."${system}";
    });
  };
in
{
  overlays = [
    lib.buildPluginOverlay
    rnix-lsp.overlay
  ];
}
