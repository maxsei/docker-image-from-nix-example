
# Docker Image from Nix

The goal of this repo is to dockerize a simple go program using `nix-build` and `docker load`.

## Stream of Conciousness
0. Create hello.go
1. Look up a `go` project that I know of in [nixpkgs](https://github.com/NixOS/nixpkgs) for reference. In this case I'm referencing [dive](https://github.com/wagoodman/dive) with [this derivation](https://github.com/NixOS/nixpkgs/blob/b542cc75fa03a3a29350d4c3b69739e946268a93/pkgs/development/tools/dive/default.nix) in nixpkgs.
2. `wget https://raw.githubusercontent.com/NixOS/nixpkgs/nixos-22.05/pkgs/development/tools/dive/default.nix`
3. Make changes to `./default.nix` to suite the needs for my hello go program.
4. Tag version/create release on github (tar archive format)
5. Try to build with nix
6. Try to build with docker
