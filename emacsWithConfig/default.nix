{ pkgs, lib }:

emacsPkg: configPkg:

# XDG_CONFIG_HOME support is only available in >= 27.1
assert lib.strings.versionAtLeast emacsPkg.version "27.1";

let
  emacsWithPackages = (pkgs.emacsPackagesFor emacsPkg).emacsWithPackages;
  emacs = emacsWithPackages configPkg;

  config = pkgs.linkFarm [{
    name = "emacs";
    path = configPkg;
  }];

in pkgs.runCommand "${emacsPkg.pname}-with-config-${emacsPkg.version}" {
  nativeBuildInputs = [
    pkgs.makeWrapper emacs
  ];
} ''
mkdir -p "$out/bin"
cp ${emacs}/bin/* $out/bin/
for prog in ${emacs}/bin/{emacs,emacs-*}; do
  local progname=$(basename "$prog")
  rm -f "$out/bin/$progname"
  # TODO: add checks to wrapper to ensure $XDG_CONFIG_HOME/emacs/init.el
  # isn't being overridden by any other emacs config location
  makeWrapper "$prog" "$out/bin/$progname" \
    --run 'export NIX_STORED_XDG_CONFIG_HOME=$XDG_CONFIG_HOME' \
    --set XDG_CONFIG_HOME ' '
done

mkdir -p $out/share
# Link icons and desktop files into place
for dir in applications icons info man; do
  ln -s $emacs/share/$dir $out/share/$dir
done
''
