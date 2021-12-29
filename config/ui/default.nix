{ configBuild
# emacsPackages
, dashboard

, selectrum, selectrum-prescient
, marginalia
}:

configBuild {
  pname = "ui";

  packageRequires = [
    dashboard

    selectrum selectrum-prescient
    marginalia
  ];

  src = ./.;
}
