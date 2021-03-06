{ configBuild
# package sets
, configPackages
, melpaPackages
# emacsPackages
, nix-mode, haskell-mode, yaml-mode
, markdown-mode, lua-mode, rust-mode
, pinentry, langtool
}:

configBuild {
  pname = "init";
  version = "0.0.1";

  packageRequires = (with configPackages; [
    ui quick-ui neuter-package-el

    org-mode magit
  ]) ++ (with melpaPackages; [
    pcsv
  ]) ++ [
    nix-mode haskell-mode yaml-mode
    markdown-mode lua-mode rust-mode

    pinentry

    langtool
  ];

  src = ./.;
}
