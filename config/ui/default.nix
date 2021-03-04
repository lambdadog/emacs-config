{ configBuild
# emacsPackages
, dashboard
}:

configBuild {
  pname = "ui";
  version = "0.0.1";

  packageRequires = [
    dashboard
  ];

  src = ./.;
}
