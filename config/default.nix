{ pkgs, lib }:

emacsPackages:

let
  callPackage = lib.callPackageWith
    (pkgs // emacsPackages // { inherit configBuild; } // configPkgs);
  configBuild = args: emacsPackages.trivialBuild ({
    preBuild = ''
    for elfile in *.el; do
      mv $elfile config-$elfile
    done
    '';
  } // args // {
    pname = "config-${args.pname}";
  });
  configPkgs = {
    init = callPackage ./init {};
  };
in configPkgs
