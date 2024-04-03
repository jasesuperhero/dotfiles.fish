local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

-- Install Lazy.nvim if needed
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.opt.termguicolors = true -- enable 24-bit RGB colors

require("lazy").setup {
  root = vim.fn.stdpath "data" .. "/lazy", -- directory where plugins will be installed
  spec = {
    { import = "plugins" },
    { import = "plugins.lsp" },
  },
  lockfile = vim.fn.stdpath "config" .. "/lazy-lock.json", -- lockfile generated after running update.
  defaults = {
    lazy = false, -- should plugins be lazy-loaded?
    version = nil,
    -- version = "*", -- enable this to try installing the latest stable versions of plugins
  },
  install = {
    -- install missing plugins on startup
    missing = true,
    -- try to load one of these colorschemes when starting an installation during startup
    colorscheme = { "catppuccin" },
  },
  checker = {
    -- automatically check for plugin updates
    enabled = true,
    -- get a notification when new updates are found
    -- disable it as it's too annoying
    notify = false,
    -- check for updates every day
    frequency = 86400,
  },
  change_detection = {
    -- automatically check for config file changes and reload the ui
    enabled = true,
    -- get a notification when changes are found
    -- disable it as it's too annoying
    notify = false,
  },
  performance = {
    cache = {
      enabled = true,
    },
  },
  state = vim.fn.stdpath "state" .. "/lazy/state.json", -- state info for checker and other things
}

-- Load local configs
local modules = {
  "config.autocmds",
  "config.options",
  "config.keymaps",
  "config.utils",
}

for _, mod in ipairs(modules) do
  local ok, err = pcall(require, mod)
  -- config.custom may be empty. It's a optional module
  if not ok and not mod == "config/custom" then error(("Error loading %s...\n\n%s"):format(mod, err)) end
end

-- Observe system theme changing
require "lua.config.watch_theme"
