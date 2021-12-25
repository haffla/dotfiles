#!/bin/bash

ln -sFf $(pwd)/nvim ~/.config/nvim
ln -sFf $(pwd)/nixpkgs ~/.config/nixpkgs
ln -sf $(pwd)/darwin-configuration.nix ~/.nixpkgs/darwin-configuration.nix
ln -sf $(pwd)/.asdfrc ~/.asdfrc
