{ configBuild

, magit
}:

configBuild {
  pname = "magit";
  version = "0.0.1";

  packageRequires = [
    magit
  ];

  src = ./.;
}
