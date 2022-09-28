# Intened to for convience of calling `nix-build build.nix`
{ 
  pkgs ? import <nixpkgs> { },
}:
with import <nixpkgs> {}; callPackage ./default.nix {
}
