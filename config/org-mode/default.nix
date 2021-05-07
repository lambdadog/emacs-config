{ configBuild
# emacsPackages
, org
}:

configBuild {
  pname = "org-mode";
  version = "0.0.1";

  packageRequires = [
    org
  ];

  src = ./.;
}
