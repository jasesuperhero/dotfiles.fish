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

-- jsonls: load schemas from SchemaStore
vim.lsp.config("jsonls", {
  settings = {
    json = {
      schemas = require("schemastore").json.schemas(),
      format = { enable = true },
      validate = { enable = true },
    },
  },
})

-- yamlls: load schemas from SchemaStore
vim.lsp.config("yamlls", {
  capabilities = {
    textDocument = {
      foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      },
    },
  },
  settings = {
    redhat = { telemetry = { enabled = false } },
    yaml = {
      schemas = require("schemastore").yaml.schemas(),
      keyOrdering = false,
      format = { enable = true },
      validate = true,
      schemaStore = { enable = false, url = "" },
    },
  },
})
