{ configBuild
# emacsPackages
, doom-themes
}:

configBuild {
  pname = "quick-ui";
  version = "0.0.1";

  packageRequires = [
    doom-themes
  ];

  src = ./.;
}
