{
  description = "Dev environment for working on my personal site.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }: 
    let
      supportedSystems = [ "x86_64-darwin" "x86_64-linux" ];
      forEachSupportedSystem = f: nixpkgs.lib.genAttrs supportedSystems (system: f {
        pkgs = import nixpkgs { inherit system; };
      });
    in
    {
      devShells = forEachSupportedSystem ({ pkgs }: {
        default = pkgs.mkShell {
          shellHook = ''
            echo "Updating git submodules..."
            (git submodule update --init --recursive && echo Done.) || echo "Failed to install git submodules. Please run 'git submodule update --init --recursive' to install the site's theme."
          '';
          packages = with pkgs; [
            hugo
            git                     # git is likely already installed, but ensure it is installed so we can download submodules in shell hook
          ];
        };
      });
    };
}
