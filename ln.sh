#!/bin/bash

mkdir -p ~/.config/karabiner
mkdir -p ~/.nixpkgs

rm -rf ~/.config/nixpkgs

ln -sFf $(pwd)/nvim ~/.config/nvim
ln -sFf $(pwd)/nixpkgs ~/.config/nixpkgs
ln -sf $(pwd)/darwin-configuration.nix ~/.nixpkgs/darwin-configuration.nix
ln -sf $(pwd)/.asdfrc ~/.asdfrc
ln -sf $(pwd)/karabiner.json ~/.config/karabiner/karabiner.json
