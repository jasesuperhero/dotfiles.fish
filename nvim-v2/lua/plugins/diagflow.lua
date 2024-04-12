return {
  -- diagflow.nvim is a Neovim plugin that provides a neat and distraction-free way to display
  -- LSP diagnostics. It shows diagnostics in virtual text at the top-right corner of your screen,
  -- only when the cursor is positioned over the problematic code or across an entire line,
  -- according to your preference. This provides a clean and focused coding environment.
  -- This approach to diagnostics management is inspired by the Helix editor.
  "dgagn/diagflow.nvim",
  lazy = true,
  event = "LspAttach",
  dependencies = { "neovim/nvim-lspconfig" },
  opts = {
    enable = true,
    max_width = 60, -- The maximum width of the diagnostic messages
    max_height = 10, -- the maximum height per diagnostics
    severity_colors = { -- The highlight groups to use for each diagnostic severity level
      error = "DiagnosticFloatingError",
      warning = "DiagnosticFloatingWarn",
      info = "DiagnosticFloatingInfo",
      hint = "DiagnosticFloatingHint",
    },
    format = function(diag) return diag.message end,
    gap_size = 1,
    scope = "cursor", -- 'cursor', 'line' this changes the scope, so instead of showing errors under the cursor, it shows errors on the entire line.
    padding_top = 1,
    padding_right = 0,
    text_align = "left", -- 'left', 'right'
    placement = "top", -- 'top', 'inline'
    inline_padding_left = 0, -- the padding left when the placement is inline
    update_event = { "DiagnosticChanged", "BufReadPost" }, -- the event that updates the diagnostics cache
    toggle_event = {}, -- if InsertEnter, can toggle the diagnostics on inserts
    show_sign = true, -- set to true if you want to render the diagnostic sign before the diagnostic message
    show_borders = false,
    render_event = { "DiagnosticChanged", "CursorMoved" },
  },
}
