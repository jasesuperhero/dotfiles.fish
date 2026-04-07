require("nvchad.configs.lspconfig").defaults()

-- LSP keymaps (on top of NvChad defaults: gd, gD, <leader>D, <leader>ra)
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local map = vim.keymap.set
    local buf = args.buf
    map("n", "gr", "<cmd>Telescope lsp_references<cr>", { buffer = buf, desc = "References" })
    map(
      "n",
      "gI",
      function() require("telescope.builtin").lsp_implementations { reuse_win = true } end,
      { buffer = buf, desc = "Goto Implementation" }
    )
    map(
      "n",
      "gy",
      function() require("telescope.builtin").lsp_type_definitions { reuse_win = true } end,
      { buffer = buf, desc = "Goto Type Definition" }
    )
    map("n", "gK", vim.lsp.buf.signature_help, { buffer = buf, desc = "Signature Help" })
    map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { buffer = buf, desc = "Code Action" })
    map({ "n", "v" }, "<leader>cc", vim.lsp.codelens.run, { buffer = buf, desc = "Run Codelens" })
    map("n", "<leader>cC", vim.lsp.codelens.refresh, { buffer = buf, desc = "Refresh & Display Codelens" })
    map(
      { "n", "v" },
      "<leader>cA",
      function() vim.lsp.buf.code_action { context = { only = { "source" }, diagnostics = {} } } end,
      { buffer = buf, desc = "Source Action" }
    )
    map("n", "<leader>cr", vim.lsp.buf.rename, { buffer = buf, desc = "Rename" })
    map("n", "<leader>cl", "<cmd>LspInfo<cr>", { buffer = buf, desc = "Lsp Info" })
  end,
})

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
