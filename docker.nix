#...
{ 
  pkgs ? import <nixpkgs> { },
}:
let
  default = with import <nixpkgs> {}; callPackage ./default.nix {};
in
  pkgs.dockerTools.buildImage {
    name = "hello-docker";
    config = {
      Cmd = [ "${default}/bin/hello" ];
    };
  }
