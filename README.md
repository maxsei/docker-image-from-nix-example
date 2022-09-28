
# Docker Image from Nix

The goal of this repo is to dockerize a simple go program using `nix-build` and `docker load`.

## Stream of Conciousness
0. Create hello.go
1. Look up a `go` project that I know of in [nixpkgs](https://github.com/NixOS/nixpkgs) for reference. In this case I'm referencing [dive](https://github.com/wagoodman/dive) with [this derivation](https://github.com/NixOS/nixpkgs/blob/b542cc75fa03a3a29350d4c3b69739e946268a93/pkgs/development/tools/dive/default.nix) in nixpkgs.
2. `wget https://raw.githubusercontent.com/NixOS/nixpkgs/nixos-22.05/pkgs/development/tools/dive/default.nix`
3. Make changes to `./default.nix` to suite the needs for my hello go program.
4. Tag version/create release on github (tar archive format)
5. Try to push to GitHub and get IP banned on port 22 lol wtf
6. Go to coffee shop the next day and just...
7. Try to build with nix `nix-build -E 'with import <nixpkgs> {}; callPackage ./default.nix {}'`
7. Can't build until we have a valid SRI hash for this repo. We can get this with the command below. Then we set in `buildGoModule.src.sha256`.
```bash
nix-prefetch-url --unpack --print-path --type sha256 \
	https://github.com/maxsei/docker-image-from-nix-example/archive/v0.0.1.tar.gz \
	| head -n 1 | xargs printf "sha256:%s" | xargs nix to-base64
```

* alternatively just set  `buildGoModule.src.sha256` temporarily to `sha256-0000000000000000000000000000000000000000000=`. Copy the "got" sha256 digest and use `nix to-base64` to convert. Update `buildGoModule.src.sha256` to the base64 value.

8. Build again with nix `nix-build -E 'with import <nixpkgs> {}; callPackage ./default.nix {}'`. Gotcha bitch!
9. convert nix build to docker build.
10. [read](https://nix.dev/tutorials/building-and-running-docker-images) this is better suited with a seperate nix file for building in docker
11. build **single docker layer** and load into docker with `nix-build docker.nix -o result-docker && docker load < result-docker `
12. inspect with `dive` and see a single layer with one directory called `nix` that has everything we need for this container.
13. run docker container `docker run hello-docker:8dwl4g766ni1z4ijhivc6kr0pvd91677` andddd it doesn't work
14. 

## Learnings
* older versions of nix used to use base32 now we use base64
`nix-prefetch-url --unpack --print-path --type sha256 https://github.com/maxsei/docker-image-from-nix-example/archive/v0.0.1.tar.gz` gets url, takes sha256 **of path** (kind of like how `nix hash-path` works) of untarred path. However this outputs the raw sha256 (or hashing algo of your choice) digest and not the base64 hash we need for nix derivations.
* To get base(32/64) version (the thing thats actually used the most nix derivations) of a hash do `nix to-base64 '<hash type>:<hash digest>'`
* nix uses `nix hash-path` outputs base64 hash the is used in modern nix derivations e.g. `<hash type>:<hash digest>`
* use a git hash revision instead of a tag while developing
* Docs on building go packages in the [nix manual](https://nixos.org/manual/nixpkgs/stable/#ssec-language-go)
