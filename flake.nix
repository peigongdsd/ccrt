{
  description = "Common Compact Runtime (ccrt)";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  outputs = { nixpkgs, self, ... }: let
    builder = nixpkgs.lib.nixosSystem { 
      system = "x86_64-linux"; 
      modules = [
        "${nixpkgs}/nixos/modules/profiles/minimal.nix"
	./nspawn.nix
	./yggdrasil.nix
      ];
    };
  in {
    inherit builder;
    packages.x86_64-linux.default = builder.config.system.build.toplevel;
  };
}
