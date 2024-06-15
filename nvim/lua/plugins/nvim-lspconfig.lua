return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      solargraph = {
        cmd = {
          "asdf",
          "exec",
          "solargraph",
          "stdio",
        },
      },
    },
  },
}
