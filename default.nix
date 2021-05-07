{ sources ? import ./nix/sources.nix }:

with import sources.nixpkgs {
  overlays = [
    (import sources.emacs-overlay)
  ];
};

let
  emacsWithConfig = callPackage ./emacsWithConfig {};
  emacs = emacsPgtk;
  emacsPackages = emacsPackagesFor emacs;
  config = (emacsPackages.callPackage ./config {
    inherit emacsPackages;
  }).init;
in emacsWithConfig emacs config
