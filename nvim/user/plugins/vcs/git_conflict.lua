return {
  "akinsho/git-conflict.nvim",
  event = "User AstroGitFile",
  cmd = {
    "GitConflictChooseOurs",
    "GitConflictChooseTheirs",
    "GitConflictChooseBoth",
    "GitConflictChooseNone",
    "GitConflictNextConflict",
    "GitConflictPrevConflict",
    "GitConflictListQf",
  },
  config = function() require("git-conflict").setup() end,
}
