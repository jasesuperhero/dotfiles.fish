return {
  "akinsho/git-conflict.nvim",
  event = "User AstroGitFile",
  config = function() require("git-conflict").setup() end,
}
