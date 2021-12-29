{ configBuild
# emacsPackages
, magit
}:

configBuild {
  pname = "magit";

  packageRequires = [
    magit
  ];

  src = ./.;
}
