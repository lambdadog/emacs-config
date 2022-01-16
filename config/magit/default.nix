{ configBuild
# emacsPackages
, magit, magit-libgit, forge
}:

configBuild {
  pname = "magit";

  packageRequires = [
    magit magit-libgit forge
  ];

  src = ./.;
}
