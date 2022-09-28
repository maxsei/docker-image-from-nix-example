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
    rev = "v${version}";
    sha256 = "sha256-X9Lm5WDzpmkNG+QGrurvb61Wo9vUIl8arKB9sbCzKxg=";
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
