{ configBuild, config }:

configBuild {
  pname = "init";
  version = "0.0.1";

  packageRequires = [
    config.test
  ];

  src = ./.;
}
