{
    description = "clipboard manager for wayland by heather7283";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
        flake-utils.url = "github:numtide/flake-utils";
    };

    outputs = { self, nixpkgs, flake-utils }:
        flake-utils.lib.eachDefaultSystem (system:
            let
                pkgs = nixpkgs.legacyPackages.${system};
            in
                {
                packages.default = pkgs.stdenv.mkDerivation {
                    pname = "cclip";
                    version = "3.3.1";
                    src = ./.;

                    nativeBuildInputs = with pkgs; [
                        meson
                        ninja
                        pkg-config
                        git
                    ];

                    buildInputs = with pkgs; [
                        sqlite
                        xxHash
                        wayland
                        wayland-scanner
                    ];

                    meta = {
                        description = "clipboard manager for wayland.";
                        homepage = "https://github.com/commrade-goad/cclip";
                    };
                };

                devShells.default = pkgs.mkShell {
                    buildInputs = with pkgs; [
                        meson
                        ninja
                        pkg-config
                        git
                        gcc

                        sqlite
                        xxHash
                        wayland-scanner
                        wayland
                    ];

                    shellHook = ''
                        echo "Use 'meson setup build' to configure your project"
                        echo "Then 'ninja -C build' to build"
                    '';
                };
            });
}
