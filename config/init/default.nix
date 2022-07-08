{ configBuild
# package sets
, configPackages
, melpaPackages
, pkgs
}:

configBuild {
  pname = "init";

  packageRequires = (with configPackages; [
    ui

    org-mode clojure

    magit mail
  ]) ++ (with melpaPackages; [
    nix-mode haskell-mode yaml-mode
    markdown-mode lua-mode rust-mode
    gdscript-mode csharp-mode renpy
    nim-mode zig-mode typescript-mode
    rescript-mode

    langtool pcsv editorconfig

    tree-sitter tree-sitter-indent
    tree-sitter-langs
  ]) ++ (with pkgs; [
    coreutils ripgrep gnupg
  ]);

  src = ./.;
}
