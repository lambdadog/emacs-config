{ pkgs, lib
, emacsPackages
}:

let
  emacsPackages' = emacsPackages // (with emacsPackages; rec {
    configPackages = let
      dirs = lib.filterAttrs (_: v: v == "directory") (builtins.readDir ./.);
    in lib.mapAttrs (dir: _: callPackage (./. + "/${dir}") {}) dirs;

    configBuild = args: trivialBuild ({
      preBuild = ''
        for elfile in *.el; do
          mv $elfile config-$elfile
        done
      '';
    } // args // {
      pname = "config-${args.pname}";
    });

    callPackage = lib.callPackageWith emacsPackages';
  });
in emacsPackages'.configPackages
