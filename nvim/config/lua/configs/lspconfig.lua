require("nvchad.configs.lspconfig").defaults()

local servers = {
  "html",
  "cssls",
  "bashls",
  "jsonls",
  "lua_ls",
  "marksman",
  "pyright",
  "solargraph",
  "ts_ls",
  "yamlls",
}
vim.lsp.enable(servers)
