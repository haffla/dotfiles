require('lualine').setup {
  sections = {
    lualine_c = {
      {
        'filename',
        path = 1, -- relative path from project root
      }
    }
  }
}
