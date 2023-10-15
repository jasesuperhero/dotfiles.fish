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
          extra_filetypes = { "toml", "solidity", "json", "markdown", "typescript" },
          extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
        },
      },
      handlers = {
        -- for prettierd
        prettierd = function()
          require("null-ls").register(require("null-ls").builtins.formatting.prettierd.with {
            condition = function(utils)
              return utils.root_has_file "package.json"
                or utils.root_has_file ".prettierrc"
                or utils.root_has_file ".prettierrc.json"
                or utils.root_has_file ".prettierrc.js"
            end,
          })
        end,
        -- For eslint_d:
        eslint_d = function()
          require("null-ls").register(require("null-ls").builtins.diagnostics.eslint_d.with {
            condition = function(utils)
              return utils.root_has_file "package.json"
                or utils.root_has_file ".eslintrc.json"
                or utils.root_has_file ".eslintrc.js"
            end,
          })
        end,
      },
    }
  end,
}
