{
  description = "Dependencies for development";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, flake-utils } @ imports: (
    flake-utils.lib.eachDefaultSystem (
      system: (
        let
          overlays = [
          ];
          pkgs = import nixpkgs { inherit overlays system; };
          baseDependencies = with pkgs; [
            python3
          ];
        in
        {
          formatter = pkgs.nixpkgs-fmt;
          devShells = rec {
            default = docs;
            docs = pkgs.mkShell {
              buildInputs = with pkgs; [
                nodejs
              ]
              ++ baseDependencies;
            };
            doc-tests = pkgs.mkShell {
              buildInputs = with pkgs; [
                cargo
                rustc
                rustfmt
              ]
              ++ baseDependencies;
            };
          };
        }
      )
    )
  );
}
