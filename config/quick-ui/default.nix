{ configBuild
# emacsPackages
, doom-themes
}:

configBuild {
  pname = "quick-ui";

  packageRequires = [
    doom-themes
  ];

  src = ./.;
}
