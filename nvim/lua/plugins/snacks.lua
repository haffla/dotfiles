return {
  {
    "folke/snacks.nvim",
    opts = function(_, opts)
      opts = opts or {}
      opts.picker = opts.picker or {}
      opts.picker.formatters = opts.picker.formatters or {}

      -- Override the file formatter behavior
      opts.picker.formatters.file = vim.tbl_deep_extend("force", opts.picker.formatters.file or {}, {
        truncate = 1000,
      })

      return opts
    end,
  },
}
