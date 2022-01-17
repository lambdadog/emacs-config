{ dev ? false }:

let
  sources = import ./nix/sources.nix;
  emacsNix =
    if dev
    then import ../emacs-nix {}
    else import sources.emacs-nix {};
in

with emacsNix;

emacsWithConfig emacsVersions.emacsPgtkGcc {
  emacsDir = "~/.local/share/emacs/";
  init = ep: (ep.callPackage ./config {}).init;
  earlyInit = ep: (ep.callPackage ./config {}).early-init;
}
