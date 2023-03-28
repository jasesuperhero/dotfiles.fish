-- customize mason plugins
return {
  {
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
  },
  {
    "jay-babu/mason-null-ls.nvim",
    opts = {
      ensure_installed = {
        "black",
        "clang-format",
        "isort",
        "prettier",
        "shellcheck",
        "shfmt",
        "stylua",
      },
    },
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    opts = {
      ensure_installed = {
        "python",
        "bash",
      },
    },
    config = function(_, opts)
      local mason_nvim_dap = require "mason-nvim-dap"
      mason_nvim_dap.setup(opts) -- run setup

      mason_nvim_dap.setup_handlers {
        lua = function(_)
          local dap = require "dap"

          dap.configurations.lua = {
            {
              type = "nlua",
              request = "attach",
              name = "Attach to running Neovim instance",
              host = function()
                local value = vim.fn.input "Host [127.0.0.1]: "
                if value ~= "" then return value end
                return "127.0.0.1"
              end,
              port = function()
                local val = tonumber(vim.fn.input("Port: ", "8086"))
                assert(val, "Please provide a port number")
                return val
              end,
            },
          }

          dap.adapters.nlua = function(callback, config)
            callback { type = "server", host = config.host, port = config.port }
          end
        end,
      }
    end,
  },
}
