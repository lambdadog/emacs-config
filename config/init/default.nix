{ configBuild
# package sets
, configPackages
, melpaPackages
, pkgs
}:

configBuild {
  pname = "init";

  packageRequires = (with configPackages; [
    ui

    org-mode clojure magit
  ]) ++ (with melpaPackages; [
    nix-mode haskell-mode yaml-mode
    markdown-mode lua-mode rust-mode
    gdscript-mode csharp-mode renpy

    langtool pcsv
  ]) ++ (with pkgs; [
    coreutils ripgrep
  ]);

  src = ./.;
}
