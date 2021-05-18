{ sources ? import ./nix/sources.nix }:

with import sources.nixpkgs {
  overlays = [
    (import sources.emacs-overlay)
  ];
};

let
  emacsWithConfig = callPackage ./emacsWithConfig {};
  # We can't currently use emacsPgtkGcc with nixpkgs master
  # since the pgtk branch is behind the changes mentioned here:
  # https://lists.gnu.org/archive/html/emacs-devel/2021-05/msg00271.html
  #
  # Once this is fixed I'd like to switch back to pgtk emacs
  emacs = emacsGcc;
  config = (emacs.pkgs.callPackage ./config {}).init;
in emacsWithConfig emacs config
