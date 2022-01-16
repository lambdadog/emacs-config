{ configBuild
# emacsPackages
, cider, clojure-mode
}:

configBuild {
  pname = "clojure";

  packageRequires = [
    cider clojure-mode
  ];

  src = ./.;
}
