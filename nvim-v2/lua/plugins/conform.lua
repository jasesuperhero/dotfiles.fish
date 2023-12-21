return {
  "stevearc/conform.nvim",
  dependencies = { "mason.nvim", "WhoIsSethDaniel/mason-tool-installer.nvim" },
  lazy = true,
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>cF",
      function() require("conform").format { formatters = { "injected" }, timeout_ms = 3000 } end,
      mode = { "n", "v" },
      desc = "Format Injected Langs",
    },
    {
      -- Customize or remove this keymap to your liking
      "<leader>cf",
      function() require("conform").format { async = true, lsp_fallback = true } end,
      mode = "",
      desc = "Format buffer",
    },
  },
  opts = User.table.merge_options {
    -- The options you set here will be merged with the builtin formatters.
    -- You can also define any custom formatters here.
    formatters = {
      injected = { options = { ignore_errors = true } },
    },
    -- Set up format-on-save
    format_on_save = { timeout_ms = 500, lsp_fallback = true },
  },
  init = function()
    -- If you want the formatexpr, here is the place to set it
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}
