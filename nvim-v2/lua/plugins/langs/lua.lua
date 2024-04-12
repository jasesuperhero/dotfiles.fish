return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = User.table.merge_options {
      ensure_installed = {
        "lua",
        "luadoc",
        "luap",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = User.table.merge_options {
      servers = {
        lua_ls = {
          -- mason = false, -- set to false if you don't want this server to be installed with mason
          -- Use this to add any additional keymaps
          -- for specific lsp servers
          -- keys = {},
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              codeLens = {
                enable = true,
              },
              completion = {
                callSnippet = "Replace",
              },
              hint = {
                enable = true,
                setType = true,
              },
            },
          },
        },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = User.table.merge_options {
      formatters_by_ft = {
        ["lua"] = { "stylua" },
      },
    },
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    optional = true,
    opts = User.table.merge_options {
      ensure_installed = {
        "stylua",
      },
    },
  },
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      {
        "jbyuki/one-small-step-for-vimkind",
                -- stylua: ignore
                config = function()
                    local dap = require("dap")
                    dap.adapters.nlua = function(callback, conf)
                        local adapter = {
                            type = "server",
                            host = conf.host or "127.0.0.1",
                            port = conf.port or 8086,
                        }
                        if conf.start_neovim then
                            local dap_run = dap.run
                            dap.run = function(c)
                                adapter.port = c.port
                                adapter.host = c.host
                            end
                            require("osv").run_this()
                            dap.run = dap_run
                        end
                        callback(adapter)
                    end
                    dap.configurations.lua = {
                        {
                            type = "nlua",
                            request = "attach",
                            name = "Run this file",
                            start_neovim = {},
                        },
                        {
                            type = "nlua",
                            request = "attach",
                            name = "Attach to running Neovim instance (port = 8086)",
                            port = 8086,
                        },
                    }
                end,
      },
    },
  },
}
