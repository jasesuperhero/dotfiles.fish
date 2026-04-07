_G.theme_watcher = {}

theme_watcher.colorFile = vim.fn.expand "~/.vimrc.color"
theme_watcher.w = vim.uv.new_fs_event()

local function apply_nvchad_theme()
  local theme = vim.o.background == "dark" and "catppuccin" or "catppuccin-latte"
  require("nvconfig").base46.theme = theme
  require("base46").load_all_highlights()
  vim.api.nvim_exec_autocmds("ColorScheme", { modeline = false })
end

function theme_watcher.watch_file(fname)
  local fullpath = vim.api.nvim_call_function("fnamemodify", { fname, ":p" })
  theme_watcher.w:start(fullpath, {}, vim.schedule_wrap(function() theme_watcher.on_change() end))
end

function theme_watcher.on_change()
  vim.api.nvim_command("luafile " .. theme_watcher.colorFile)
  apply_nvchad_theme()
  theme_watcher.w:stop()
  theme_watcher.watch_file(theme_watcher.colorFile)
end

vim.schedule(function()
  if vim.fn.filereadable(theme_watcher.colorFile) == 1 then
    vim.api.nvim_command("luafile " .. theme_watcher.colorFile)
    apply_nvchad_theme()
  end
end)

theme_watcher.watch_file(theme_watcher.colorFile)
