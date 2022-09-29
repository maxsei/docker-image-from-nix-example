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
  name = "hello";
  version = "0.0.1";

  src = fetchFromGitHub {
    owner = owner;
    repo = repo;
    rev = "7d56e1031b79ccabf683d340276e1a29673b93c5";
    sha256 = "sha256-uTM7D4x7/2S/oGWGOjV2dD6YfRNJxaCY0gQNAJ9jDx8=";
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
