{ configBuild
, elpaPackages, melpaPackages
, imagemagick
}:

configBuild {
  pname = "org-mode";

  packageRequires = (with elpaPackages; [
    org
  ]) ++ (with melpaPackages; [
    ox-bb
  ]) ++ [
    imagemagick
  ];

  src = ./.;
}
