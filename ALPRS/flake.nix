{
  description = "Dev flake for ALPRS exercises";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.11";
  };

  outputs = { nixpkgs, ... }: let
    pkgs = nixpkgs.legacyPackages.x86_64-linux;

    py = pkgs.python313.withPackages (p: with p; [ ruff numpy ]);
  in {
    devShells.x86_64-linux.default = pkgs.mkShellNoCC {
      packages = [ py ] ++ (with pkgs; [
        basedpyright
      ]);
    };
  };
}
