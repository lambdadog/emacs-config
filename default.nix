{ sources ? import ./nix/sources.nix }:

with import sources.nixpkgs {
  overlays = [
    (import sources.emacs-overlay)
  ];
};

let
  emacsWithConfig = callPackage ./emacsWithConfig {};
  emacs = emacsPgtkGcc;
  config = ((emacsPackagesFor emacs).callPackage ./config {}).init;
in emacsWithConfig emacs config
