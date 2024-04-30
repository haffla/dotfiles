require("formatter").setup {
  logging = true,
  log_level = vim.log.levels.WARN,
  filetype = {
    ruby = {
      require('formatter.filetypes.ruby').rubocop,
    }
  }
}

