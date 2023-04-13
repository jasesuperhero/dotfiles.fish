return {
  "williamboman/mason-lspconfig.nvim",
  opts = {
    ensure_installed = {
      "bashls",
      "clangd",
      "lua_ls",
      "pyright",
      "solargraph",
    },
  },
}
