return {
  "jay-babu/mason-null-ls.nvim",
  event = { "BufReadPost", "BufNewFile" },
  config = function(_, opts)
    local mason_null_ls = require "mason-null-ls"
    local null_ls = require "null-ls"

    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
    local formatting = null_ls.builtins.formatting

    mason_null_ls.setup {
      ensure_installed = {
        "black",
        "clang-format",
        "isort",
        "prettierd",
        "shellcheck",
        "shfmt",
        "stylua",
      },
      sources = {
        formatting.prettier.with {
          extra_filetypes = { "toml", "solidity", "json", "markdown" },
          extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
        },
      },
    }
  end,
}
