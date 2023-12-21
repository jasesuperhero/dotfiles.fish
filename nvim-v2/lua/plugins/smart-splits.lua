return {
  "mrjones2014/smart-splits.nvim",
  lazy = true,
  keys = {
    {
      "<Up>",
      function() require("smart-splits").resize_up(2) end,
      desc = "Resize split up",
    },
    {
      "<Down>",
      function() require("smart-splits").resize_down(2) end,
      desc = "Resize split down",
    },
    {
      "<Left>",
      function() require("smart-splits").resize_left(2) end,
      desc = "Resize split left",
    },
    {
      "<Right>",
      function() require("smart-splits").resize_right(2) end,
      desc = "Resize split right",
    },
  },
  opts = {
    ignored_filetypes = { "nofile", "quickfix", "qf", "prompt" },
    ignored_buftypes = { "nofile" },
  },
}
