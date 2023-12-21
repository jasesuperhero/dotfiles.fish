return {
  "kevinhwang91/nvim-ufo",
  lazy = true,
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { "kevinhwang91/promise-async" },
  keys = {
    { "zR", function() require("ufo").openAllFolds() end, desc = "Open all folds" },
    { "zM", function() require("ufo").closeAllFolds() end, desc = "Close all folds" },
    { "zk", function() require("ufo").goPreviousStartFold() end, desc = "Go previous start fold" },
    { "zn", function() require("ufo").goNextClosedFold() end, desc = "Go next start fold" },
    { "zp", function() require("ufo").goPreviousClosedFold() end, desc = "Go previous closed fold" },
  },
  config = function()
    local ufo = require "ufo"

    local handler = function(virtText, lnum, endLnum, width, truncate)
      local newVirtText = {}
      local suffix = (" " .. User.icons.folds.separator .. " %d "):format(endLnum - lnum)
      local sufWidth = vim.fn.strdisplaywidth(suffix)
      local targetWidth = width - sufWidth
      local curWidth = 0
      for _, chunk in ipairs(virtText) do
        local chunkText = chunk[1]
        local chunkWidth = vim.fn.strdisplaywidth(chunkText)
        if targetWidth > curWidth + chunkWidth then
          table.insert(newVirtText, chunk)
        else
          chunkText = truncate(chunkText, targetWidth - curWidth)
          local hlGroup = chunk[2]
          table.insert(newVirtText, { chunkText, hlGroup })
          chunkWidth = vim.fn.strdisplaywidth(chunkText)
          -- str width returned from truncate() may less than 2nd argument, need padding
          if curWidth + chunkWidth < targetWidth then
            suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
          end
          break
        end
        curWidth = curWidth + chunkWidth
      end
      table.insert(newVirtText, { suffix, "MoreMsg" })
      return newVirtText
    end

    ---@diagnostic disable-next-line: missing-fields
    ufo.setup {
      fold_virt_text_handler = handler,
      preview = {
        win_config = {
          border = "rounded",
          winhighlight = "Normal:Normal",
          winblend = 0,
        },
      },
      provider_selector = function(_, _, _) return { "treesitter" } end,
    }
  end,
}
