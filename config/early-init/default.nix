{ configBuild, melpaPackages }:

configBuild {
  pname = "early-init";

  packageRequires = (with melpaPackages; [
    doom-themes
  ]);

  src = ./.;
}
