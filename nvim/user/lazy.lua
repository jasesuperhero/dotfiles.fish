return {
  defaults = { lazy = true },
  change_detection = {
    enabled = true,
    notify = true,
  },
  performance = {
    rtp = {
      -- customize default disabled vim plugins
      disabled_plugins = {
        "tohtml",
        "gzip",
        "matchit",
        "zipPlugin",
        "netrwPlugin",
        "tarPlugin",
        "matchparen",
      },
    },
  },
}
