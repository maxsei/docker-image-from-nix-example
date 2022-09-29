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
      # Cmd = [ "${default}/bin/${default.pname}" ];
      Cmd = [ "${default}/bin/docker-image-from-nix-example" ];
    };
  }
