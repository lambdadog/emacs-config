{ configBuild, config
# emacsPackages
, nix-mode, haskell-mode, yaml-mode
, markdown-mode, lua-mode, rust-mode
, magit, pinentry, langtool
}:

configBuild {
  pname = "init";
  version = "0.0.1";

  packageRequires = [
    config.ui
    config.quick-ui
    config.neuter-package-el

    # Extra Packages
    nix-mode haskell-mode yaml-mode
    markdown-mode lua-mode rust-mode

    magit pinentry

    langtool
  ];

  src = ./.;
}
