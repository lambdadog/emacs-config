{ configBuild
# package sets
, configPackages
, melpaPackages
# emacsPackages
, nix-mode, haskell-mode, yaml-mode
, markdown-mode, lua-mode, rust-mode
, gdscript-mode, csharp-mode, renpy
, pinentry, langtool
}:

configBuild {
  pname = "init";

  packageRequires = (with configPackages; [
    ui quick-ui neuter-package-el

    org-mode clojure magit
  ]) ++ (with melpaPackages; [
    pcsv
  ]) ++ [
    nix-mode haskell-mode yaml-mode
    markdown-mode lua-mode rust-mode
    gdscript-mode csharp-mode renpy

    pinentry

    langtool
  ];

  src = ./.;
}
