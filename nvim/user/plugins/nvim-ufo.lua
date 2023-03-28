return {
  "kevinhwang91/nvim-ufo",
  opt = true,
  event = { "BufReadPre" },
  wants = { "promise-async" },
  requires = "kevinhwang91/promise-async",
  config = function()
    require("ufo").setup {
      provider_selector = function(_, _) return { "lsp", "indent" } end,
    }

    vim.keymap.set("n", "zR", require("ufo").openAllFolds)
    vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
  end,
}
