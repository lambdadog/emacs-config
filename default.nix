{ sources ? import ./nix/sources.nix }:

with import sources.nixpkgs {
  overlays = [
    (import sources.emacs-overlay)
  ];
};

let
  emacsWithConfig = callPackage ./emacsWithConfig {};
  emacs = emacsGcc;
  config = ((emacsPackagesFor emacs).callPackage ./config {}).init;
in config #emacsWithConfig emacs config
