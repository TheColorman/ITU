{
  description = "Dev flake for ALPRS exercises";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.11";
  };

  outputs = { nixpkgs, ... }: let
    pkgs = nixpkgs.legacyPackages.x86_64-linux;

    python = pkgs.python313.withPackages (p: with p; [ ruff ]);
  in {
    devShells.x86_64-linux.default = pkgs.mkShellNoCC {
      packages = [ python ];
    };
  };
}
