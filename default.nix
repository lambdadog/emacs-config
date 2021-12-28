let
  sources = import ./nix/sources.nix;
  emacsNix = import sources.emacs-nix;
in

with emacsNix;

emacsPgtkGcc.withConfig {
  emacsDir = "~/.local/share/emacs";
  init = (emacsPgtkGcc.packages.callPackage ./config {}).init;
}
