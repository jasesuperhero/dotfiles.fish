return {
  "lukas-reineke/headlines.nvim",
  lazy = true,
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    markdown = {
      fat_headlines = true,
    },
  },
}
