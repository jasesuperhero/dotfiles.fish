return {
  "lvimuser/lsp-inlayhints.nvim",
  event = "LspAttach",
  opts = {
    inlay_hints = {
      highlight = "Comment",
      labels_separator = " ⏐ ",
      parameter_hints = { prefix = "" },
      type_hints = { prefix = "=> ", remove_colon_start = true },
    },
    enabled_at_startup = true,
  },
  config = function(_, opts) require("lsp-inlayhints").setup(opts) end,
}
