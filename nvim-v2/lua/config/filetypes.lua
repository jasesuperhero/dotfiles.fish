-- Set up custom filetypes
-- Set up custom filetypes
vim.filetype.add {
  extension = {
    fish = "fish",
    stencil = "swift",
    kdl = "kdl",
    qmd = "markdown",
    yml = "yaml",
    yaml = "yaml",
    norg = "norg",
  },
  filename = {
    ["launch.json"] = "jsonc",
    Podfile = "ruby",
    Brewfile = "ruby",
  },
  pattern = {
    [".*%.conf"] = "conf",
    [".*%.theme"] = "conf",
    [".*%.gradle"] = "groovy",
    ["^.env%..*"] = "bash",
  },
}
