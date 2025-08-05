-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
--
-- http://www.lazyvim.org/extras/lang/ruby#nvim-lspconfig
vim.g.lazyvim_ruby_lsp = "ruby_lsp"
vim.g.lazyvim_ruby_formatter = "rubocop"

-- have at least 8 lines of context when scrolling
vim.opt.scrolloff = 10
vim.opt.colorcolumn = "120"
