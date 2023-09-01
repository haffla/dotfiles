#!/bin/bash

mkdir -p ~/.config/karabiner
mkdir -p ~/.nixpkgs

rm -rf ~/.config/home-manager

ln -sFf $(pwd)/nvim ~/.config/nvim
ln -sFf $(pwd)/home-manager ~/.config/home-manager
ln -sf $(pwd)/.asdfrc ~/.asdfrc
ln -sf $(pwd)/karabiner.json ~/.config/karabiner/karabiner.json
ln -sf $(pwd)/git/.gitignore ~/.gitignore
ln -sf $(pwd)/git/.gitconfig ~/.gitconfig
ln -sf $(pwd)/.tmux.conf ~/.tmux.conf
