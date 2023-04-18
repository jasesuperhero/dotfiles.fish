return {
  "jay-babu/mason-null-ls.nvim",
  opts = {
    ensure_installed = {
      "black",
      "clang-format",
      "isort",
      "prettierd",
      "shellcheck",
      "shfmt",
      "stylua",
    },
  },
  config = function(_, opts)
    local mason_null_ls = require "mason-null-ls"
    local null_ls = require "null-ls"
    mason_null_ls.setup(opts)

    -- mason_null_ls.setup_handlers {
    --   prettierd = function()
    --     null_ls.register(null_ls.builtins.formatting.prettierd.with { extra_filetypes = { "json", "markdown" } })
    --   end,
    -- }
  end,
}
