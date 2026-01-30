#!/bin/bash
# Reset Neovim treesitter parsers
# Run this when treesitter parsers get corrupted after LazyVim updates

echo "Removing treesitter parsers and queries..."
rm -rf ~/.local/share/nvim/lazy/nvim-treesitter/parser
rm -rf ~/.local/share/nvim/site/parser
rm -rf ~/.local/share/nvim/site/queries
echo "Done! Parsers and queries will reinstall on next Neovim startup."
