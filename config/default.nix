{ pkgs, lib }:

emacsPackages:

let
  callPackage = lib.callPackageWith
    (pkgs // emacsPackages // {
      inherit callPackage configBuild;
      config = configPkgs;
    });
  configBuild = args: emacsPackages.trivialBuild ({
    preBuild = ''
    for elfile in *.el; do
      mv $elfile config-$elfile
    done
    '';
  } // args // {
    pname = "config-${args.pname}";
  });
  configPkgs = let
    dirs = lib.filterAttrs (_: v: v == "directory") (builtins.readDir ./.);
  in lib.mapAttrs (dir: _: callPackage (./. + "/${dir}") {}) dirs;
in configPkgs
