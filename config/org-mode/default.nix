{ configBuild
# emacsPackages
, org, ox-bb
}:

configBuild {
  pname = "org-mode";

  packageRequires = [
    org ox-bb
  ];

  src = ./.;
}
