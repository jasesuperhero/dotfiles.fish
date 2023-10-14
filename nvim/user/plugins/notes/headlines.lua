return {
  "lukas-reineke/headlines.nvim",
  dependencies = "nvim-treesitter/nvim-treesitter",
  event = "User AstroFile",
  ft = { "org", "norg", "markdown", "yaml" },
  config = function()
    require("headlines").setup {
      org = { headline_highlights = false },
      norg = { headline_highlights = { "Headline" }, codeblock_highlight = false },
      markdown = { headline_highlights = { "Headline1" } },
    }
  end,
}
