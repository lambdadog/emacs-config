{ configBuild
# emacsPackages
, dashboard

, selectrum, selectrum-prescient
, marginalia
}:

configBuild {
  pname = "ui";
  version = "0.0.1";

  packageRequires = [
    dashboard

    selectrum selectrum-prescient
    marginalia
  ];

  src = ./.;
}
