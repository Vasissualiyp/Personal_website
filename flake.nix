{
  description = "Vasilii Pustovoit's Personal Website";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        packages = {
          default = pkgs.stdenv.mkDerivation {
            name = "vasilii-pustovoit-website";
            src = ./hugo-site;
            
            nativeBuildInputs = [ pkgs.hugo ];
            
            buildPhase = ''
              hugo --minify
            '';
            
            installPhase = ''
              cp -r public $out
            '';
          };
        };

        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            hugo
            git
          ];
          
          shellHook = ''
            echo "Hugo development environment loaded"
            echo "Run 'hugo server -D' to start development server"
          '';
        };

        apps.default = {
          type = "app";
          program = "${pkgs.hugo}/bin/hugo";
        };
      }
    );
}
