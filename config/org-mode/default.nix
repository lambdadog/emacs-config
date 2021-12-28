{ configBuild
# emacsPackages
, org, ox-bb
}:

configBuild {
  pname = "org-mode";
  version = "0.0.1";

  packageRequires = [
    org ox-bb
  ];

  src = ./.;
}
