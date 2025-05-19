#!/bin/bash

mkdir -p ~/.config/karabiner
mkdir -p ~/.config/fish
mkdir -p ~/.nixpkgs

ln -sFf $(pwd)/nvim ~/.config/nvim
ln -sf $(pwd)/karabiner.json ~/.config/karabiner/karabiner.json
ln -sf $(pwd)/git/.gitignore ~/.gitignore
ln -sf $(pwd)/git/.gitconfig ~/.gitconfig
ln -sf $(pwd)/.tmux.conf ~/.tmux.conf
ln -sf $(pwd)/config.fish ~/.config/fish/config.fish
