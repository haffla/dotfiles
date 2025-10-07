return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      -- Replace the "pretty_path" entry with a plain full-path filename
      opts.sections.lualine_c[4] = {
        "filename",
        path = 1, -- 0 = filename, 1 = relative path, 2 = absolute path
        shorting_target = 0, -- 0 disables truncation
      }
    end,
  },
}
