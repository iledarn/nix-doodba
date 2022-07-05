{ pkgs ? import <nixpkgs> {
#  overlays = [(import (builtins.fetchTarball {url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;}))];
}
}:
with pkgs;
let
  my-python-packages = python-packages: with python-packages; [
    ptpython
    invoke
    pre-commit
    # other python packages you want
  ];
  python-with-my-packages = python3.withPackages my-python-packages;

in
  mkShell {
    buildInputs = [
    # Customized packages
    python-with-my-packages
    jq

    fd
    ripgrep
  ];

  shellHook = ''
    alias dcd="docker compose down"
  '';
}
