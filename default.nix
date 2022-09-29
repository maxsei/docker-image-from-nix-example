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
    rev = "bdb7335bbd6a1ff43dbbbff67f6dce2569dfa295";
    sha256 = "sha256-C0BbaDdzWg8zi0j77ReJRg32jaSi6jRaAfJZw51mFQ0=";
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
