return {
  -- lsp
  require "user.plugins.lsp.lsp_inlayhints",
  require "user.plugins.lsp.lsp_kind",
  require "user.plugins.lsp.lsp_lines",
  require "user.plugins.lsp.lsp_signature",
  require "user.plugins.lsp.mason",
  require "user.plugins.lsp.neogen",

  -- formatters
  require "user.plugins.formatters.mason",

  -- dap
  require "user.plugins.dap.dap",
  require "user.plugins.dap.dap_ui",
  require "user.plugins.dap.mason",

  -- tests
  require "user.plugins.tests.neotest",
  require "user.plugins.tests.nvim-coverage",
  require "user.plugins.tests.overseer",
  require "user.plugins.tests.vim-test",

  -- vcs
  require "user.plugins.vcs.diffview",
  require "user.plugins.vcs.git_conflict",

  -- editor
  require "user.plugins.editor.cmp",
  require "user.plugins.editor.headlines",
  require "user.plugins.editor.hlargs",
  require "user.plugins.editor.indent-blankline",
  require "user.plugins.editor.mini-indentscope",
  require "user.plugins.editor.neodim",
  require "user.plugins.editor.nvim-treesitter-context",
  require "user.plugins.editor.nvim-treesitter-textobjects",
  require "user.plugins.editor.nvim-ts-rainbow2",
  require "user.plugins.editor.syntax-tree-surfer",
  require "user.plugins.editor.todo-comments",
  require "user.plugins.editor.trouble",
  require "user.plugins.editor.vim-matchup",

  -- ui
  require "user.plugins.ui.catppuccin",
  require "user.plugins.ui.neo_tree",
  require "user.plugins.ui.notify",
  require "user.plugins.ui.telescope",
  require "user.plugins.ui.heirline",

  -- disabled
  require "user.plugins._disabled.alpha",
}
