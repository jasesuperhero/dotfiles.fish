return {
  "rebelot/heirline.nvim",
  opts = function(_, opts)
    local status = require "astronvim.utils.status"
    local palette = require("catppuccin.palettes").get_palette()
    local get_icon = require("astronvim.utils").get_icon

    opts.statusline = {
      -- statusline
      hl = { fg = "fg", bg = "bg" },
      status.component.mode {
        mode_text = {
          icon = {
            kind = "VimIcon",
            padding = { right = 1 },
          },
          padding = { left = 1, right = 1 },
          surround = {
            -- set the color of the surrounding based on the current mode using astronvim.utils.status module
            color = function() return { main = status.hl.mode_bg(), right = "blank_bg" } end,
          },
        },
      },
      status.component.builder {
        {
          provider = function()
            local key = require("grapple").key()
            return "  [" .. key .. "]"
          end,
        },
        condition = require("grapple").exists,
        hl = { fg = palette.maroon },
        surround = {
          separator = "left",
        },
      },
      status.component.git_branch(),
      status.component.file_info {
        filename = { fallback = "Empty" },
        file_modified = false,
      },
      status.component.fill(),
      status.component.builder {
        {
          provider = function() return get_icon "DapIcon" + " " .. require("dap").status() end,
        },
        condition = function()
          local session = require("dap").session()
          return session ~= nil
        end,
        hl = { fg = palette.yellow },
      },
      status.component.fill(),
      status.component.cmd_info(),
      status.component.fill(),
      status.component.lsp { lsp_progress = false },
      status.component.treesitter(),
      status.component.nav(),
    }

    opts.winbar = {
      -- winbar
      init = function(self) self.bufnr = vim.api.nvim_get_current_buf() end,
      fallthrough = false,
      {
        -- inactive winbar
        condition = function() return not status.condition.is_active() end,
        status.component.separated_path(),
        status.component.file_info {
          file_icon = { hl = status.hl.file_icon "winbar", padding = { left = 0 } },
          file_modified = false,
          file_read_only = false,
          hl = status.hl.get_attributes("winbarnc", false),
          surround = false,
          update = "BufEnter",
        },
        status.component.fill(),
        status.component.git_diff {
          surround = { separator = "none", color = { main = "bg", right = "bg", left = "bg" } },
        },
        status.component.diagnostics {
          surround = { separator = "none", color = { main = "bg", right = "bg", left = "bg" } },
        },
      },
      { -- active winbar
        status.component.breadcrumbs { hl = status.hl.get_attributes("winbar", true) },
        status.component.fill(),
        status.component.git_diff {
          surround = { separator = "none", color = { main = "bg", right = "bg", left = "bg" } },
        },
        status.component.diagnostics {
          surround = { separator = "none", color = { main = "bg", right = "bg", left = "bg" } },
        },
      },
    }

    opts.tabline = { -- tabline
      {
        -- file tree padding
        condition = function(self)
          self.winid = vim.api.nvim_tabpage_list_wins(0)[1]
          return status.condition.buffer_matches(
            { filetype = { "aerial", "dapui_.", "neo%-tree", "NvimTree" } },
            vim.api.nvim_win_get_buf(self.winid)
          )
        end,
        provider = function(self) return string.rep(" ", vim.api.nvim_win_get_width(self.winid) + 1) end,
        hl = { bg = "tabline_bg" },
      },
      status.heirline.make_buflist(status.component.tabline_file_info()), -- component for each buffer tab
      status.component.fill { hl = { bg = "tabline_bg" } }, -- fill the rest of the tabline with background color
      {
        -- tab list
        condition = function() return #vim.api.nvim_list_tabpages() >= 2 end, -- only show tabs if there are more than one
        status.heirline.make_tablist { -- component for each tab
          provider = status.provider.tabnr(),
          hl = function(self) return status.hl.get_attributes(status.heirline.tab_type(self, "tab"), true) end,
        },
        {
          -- close button for current tab
          provider = status.provider.close_button { kind = "TabClose", padding = { left = 1, right = 1 } },
          hl = status.hl.get_attributes("tab_close", true),
          on_click = {
            callback = function() require("astronvim.utils.buffer").close_tab() end,
            name = "heirline_tabline_close_tab_callback",
          },
        },
      },
    }

    opts.statuscolumn = { -- statuscolumn
      status.component.numbercolumn(),
      status.component.signcolumn(),
      status.component.foldcolumn(),
    }

    -- return the final configuration table
    return opts
  end,
}
