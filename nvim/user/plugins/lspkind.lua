return {
  "onsails/lspkind.nvim",
  opts = {
    enabled = vim.g.icons_enabled,
    opts = function()
      return {
        preset = "codicons",
        symbol_map = {
          Array = "",
          Boolean = "",
          Key = "",
          Namespace = "",
          Null = "",
          Number = "",
          Object = "",
          Package = "",
          String = "",
        },
      }
    end,
  },
}
