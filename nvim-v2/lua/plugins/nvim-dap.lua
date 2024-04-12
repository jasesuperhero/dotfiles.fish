local function get_args(config)
  local args = type(config.args) == "function" and (config.args() or {}) or config.args or {}
  config = vim.deepcopy(config)
  ---@cast args string[]
  config.args = function()
    local new_args = vim.fn.input("Run with args: ", table.concat(args, " ")) --[[@as string]]
    return vim.split(vim.fn.expand(new_args) --[[@as string]], " ")
  end
  return config
end

return {
  "mfussenegger/nvim-dap",
  lazy = true,

  dependencies = {

    -- fancy UI for the debugger
    {
      "rcarriga/nvim-dap-ui",
      lazy = true,
      dependencies = { "nvim-neotest/nvim-nio" },
            -- stylua: ignore
            keys = {
                { "<leader>.u", function() require("dapui").toggle({}) end, desc = "Dap UI" },
                { "<leader>.e", function() require("dapui").eval() end,     desc = "Eval",  mode = { "n", "v" } },
            },
      opts = {},
      config = function(_, opts)
        -- setup dap config by VsCode launch.json file
        -- require("dap.ext.vscode").load_launchjs()
        local dap = require "dap"
        local dapui = require "dapui"
        dapui.setup(opts)
        dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open {} end
        dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close {} end
        dap.listeners.before.event_exited["dapui_config"] = function() dapui.close {} end
      end,
    },

    -- virtual text for the debugger
    {
      "theHamsta/nvim-dap-virtual-text",
      lazy = true,
      opts = {},
    },

    -- which key integration
    {
      "folke/which-key.nvim",
      lazy = true,
      optional = true,
      opts = {
        defaults = {
          ["<leader>."] = { name = "+debug" },
        },
      },
    },

    -- mason.nvim integration
    {
      "jay-babu/mason-nvim-dap.nvim",
      lazy = true,
      dependencies = "mason.nvim",
      cmd = { "DapInstall", "DapUninstall" },
      opts = {
        -- Makes a best effort to setup the various debuggers with
        -- reasonable debug configurations
        automatic_installation = true,

        -- You can provide additional configuration to the handlers,
        -- see mason-nvim-dap README for more information
        handlers = {},

        -- You'll need to check that you have the required things installed
        -- online, please don't ask me how to install them :)
        ensure_installed = {
          -- Update this to ensure that you have the debuggers for the langs you want
        },
      },
    },
  },

    -- stylua: ignore
    keys = {
        { "<leader>.B", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
        { "<leader>.b", function() require("dap").toggle_breakpoint() end,                                    desc = "Toggle Breakpoint" },
        { "<leader>.c", function() require("dap").continue() end,                                             desc = "Continue" },
        { "<leader>.a", function() require("dap").continue({ before = get_args }) end,                        desc = "Run with Args" },
        { "<leader>.C", function() require("dap").run_to_cursor() end,                                        desc = "Run to Cursor" },
        { "<leader>.g", function() require("dap").goto_() end,                                                desc = "Go to Line (No Execute)" },
        { "<leader>.i", function() require("dap").step_into() end,                                            desc = "Step Into" },
        { "<leader>.j", function() require("dap").down() end,                                                 desc = "Down" },
        { "<leader>.k", function() require("dap").up() end,                                                   desc = "Up" },
        { "<leader>.l", function() require("dap").run_last() end,                                             desc = "Run Last" },
        { "<leader>.o", function() require("dap").step_out() end,                                             desc = "Step Out" },
        { "<leader>.O", function() require("dap").step_over() end,                                            desc = "Step Over" },
        { "<leader>.p", function() require("dap").pause() end,                                                desc = "Pause" },
        { "<leader>.r", function() require("dap").repl.toggle() end,                                          desc = "Toggle REPL" },
        { "<leader>.s", function() require("dap").session() end,                                              desc = "Session" },
        { "<leader>.t", function() require("dap").terminate() end,                                            desc = "Terminate" },
        { "<leader>.w", function() require("dap.ui.widgets").hover() end,                                     desc = "Widgets" },
    },

  config = function()
    vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

    for name, sign in pairs(User.icons.dap) do
      sign = type(sign) == "table" and sign or { sign }
      vim.fn.sign_define(
        "Dap" .. name,
        { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
      )
    end
  end,
}
