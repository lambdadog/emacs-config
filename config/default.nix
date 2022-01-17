{ lib, overrideScope' }:

(overrideScope' (self: super: {
  configPackages = let
    dirs = lib.filterAttrs (_: v: v == "directory") (builtins.readDir ./.);
  in lib.mapAttrs (dir: _: self.callPackage (./. + "/${dir}") {}) dirs;

  configBuild = args: self.trivialBuild ({
    preBuild = ''
      for elfile in *.el; do
        mv $elfile config-$elfile
      done
    '';
  } // args // {
    pname = "config-${args.pname}";
  });
})).configPackages
