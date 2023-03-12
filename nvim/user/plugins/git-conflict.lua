return {
  "akinsho/git-conflict.nvim",
  cmd = "GitConflict",
  config = function()
    require("git-conflict").setup()
  end,
}
