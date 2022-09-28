#...
{ 
  lib,
  stdenv,
  buildGoModule,
  fetchFromGitHub,
}:
let
  owner = "maxsei";
  repo = "docker-image-from-nix-example";
in
buildGoModule rec {
  pname = "hello";
  version = "0.0.1";

  src = fetchFromGitHub {
    owner = owner;
    repo = repo;
    rev = "dd3cb3053b9f9ca9e200bd90a902d8cb4d0789c4";
    sha256 = "sha256-aksrEub950B8CDIOPwJ9nAWfEF3I7yLCFLFhQIahdw0=";
  };

  vendorSha256 = null;

  nativeBuildInputs = [];

  buildInputs = lib.optionals stdenv.isLinux [];

  ldflags = [
    "-s"
    "-w"
    "-X main.version=${version}"
  ];

  meta = with lib; {
    description = "hello example that is meant to be build by nix then from nix into docker";
    homepage = "https://github.com/${owner}/${repo}";
    license = licenses.mit;
    maintainers = with maintainers; [ owner ];
  };
}
