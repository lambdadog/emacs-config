{ pkgs, lib
, emacsPackages
}:

let
  configPkgs = emacsPackages // rec {
    configBuild = args: emacsPackages.trivialBuild ({
      preBuild = ''
        for elfile in *.el; do
          mv $elfile config-$elfile
        done
      '';
    } // args // {
      pname = "config-${args.pname}";
    });

    config = let
      dirs = lib.filterAttrs (_: v: v == "directory") (builtins.readDir ./.);
    in lib.mapAttrs (dir: _: callPackage (./. + "/${dir}") {}) dirs;

    callPackage = lib.callPackageWith configPkgs;
  };
  configBuild = args: emacsPackages.trivialBuild ({
    preBuild = ''
    for elfile in *.el; do
      mv $elfile config-$elfile
    done
    '';
  } // args // {
    pname = "config-${args.pname}";
  });
in configPkgs.config
