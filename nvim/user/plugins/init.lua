return {
  -- lsp
  require "user.plugins.lsp.cmp-nvim-lsp-signature-help",
  require "user.plugins.lsp.lsp_inlayhints",
  require "user.plugins.lsp.lsp_kind",
  require "user.plugins.lsp.lsp_lines",
  require "user.plugins.lsp.lsp_signature",
  require "user.plugins.lsp.mason",
  require "user.plugins.lsp.neodev",
  require "user.plugins.lsp.neogen",
  require "user.plugins.lsp.fidget",
  require "user.plugins.lsp.typescript-tools",

  require "user.plugins.notes.neorg",
  require "user.plugins.notes.headlines",

  -- formatters
  require "user.plugins.formatters.mason",

  -- dap
  require "user.plugins.dap.dap",
  require "user.plugins.dap.dap_ui",
  require "user.plugins.dap.mason",
  require "user.plugins.dap.nvim-dap-virtual-text",

  -- tests
  require "user.plugins.tests.neotest",
  require "user.plugins.tests.nvim-coverage",
  require "user.plugins.tests.overseer",
  require "user.plugins.tests.vim-test",

  -- vcs
  require "user.plugins.vcs.diffview",
  require "user.plugins.vcs.git_conflict",
  require "user.plugins.vcs.octo",

  -- editor
  require "user.plugins.editor.cmp",
  require "user.plugins.editor.headlines",
  require "user.plugins.editor.hlargs",
  require "user.plugins.editor.indent-blankline",
  require "user.plugins.editor.mini-indentscope",
  require "user.plugins.editor.neodim",
  require "user.plugins.editor.nvim-spectre",
  require "user.plugins.editor.nvim-treesitter-context",
  require "user.plugins.editor.nvim-treesitter-textobjects",
  require "user.plugins.editor.nvim-ts-rainbow2",
  require "user.plugins.editor.syntax-tree-surfer",
  require "user.plugins.editor.todo-comments",
  require "user.plugins.editor.trouble",
  require "user.plugins.editor.vim-matchup",
  require "user.plugins.editor.eyeliner",
  require "user.plugins.editor.vim-visual-multi",
  require "user.plugins.editor.surround",

  -- ui
  require "user.plugins.ui.catppuccin",
  require "user.plugins.ui.grapple",
  require "user.plugins.ui.heirline",
  require "user.plugins.ui.neo_tree",
  require "user.plugins.ui.notify",
  require "user.plugins.ui.telescope",

  -- disabled
  require "user.plugins._disabled.alpha",
}
