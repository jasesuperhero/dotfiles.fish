return {
  "lukas-reineke/headlines.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    markdown = {
      fat_headlines = true,
    },
  },
}
