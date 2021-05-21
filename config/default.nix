{ pkgs, lib
, emacs, emacsPackagesFor
}:

let
  emacsPackages = emacsPackagesFor emacs;

  emacsPackages' = emacsPackages // (with emacsPackages; rec {
    callPackage = lib.callPackageWith (pkgs // emacsPackages');

    configBuild = args: trivialBuild ({
      preBuild = ''
        for elfile in *.el; do
          mv $elfile config-$elfile
        done
      '';
    } // args // {
      pname = "config-${args.pname}";
    });

    configPackages = let
      dirs = lib.filterAttrs (_: v: v == "directory") (builtins.readDir ./.);
    in lib.mapAttrs (dir: _: callPackage (./. + "/${dir}") {}) dirs;
  });
in emacsPackages'.configPackages
