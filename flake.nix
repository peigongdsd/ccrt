{
  description = "Common Compact Runtime (ccrt)";
  inputs.nixpkgs.url = "github:nixos/nixpkgs";
  outputs = { nixpkgs, self, ... }: let
    builder = nixpkgs.lib.nixosSystem { 
      system = "x86_64-linux"; 
      modules = [
        "${nixpkgs}/nixos/modules/profiles/minimal.nix"
        ./configuration.nix
	./nspawn.nix
      ];
    };
  in {
    inherit builder;
    packages.x86_64-linux.default = builder.config.system.build.toplevel;
  };
}
