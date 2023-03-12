_G.theme_checker = {}

theme_checker.colorFile = vim.fn.expand "~/.vimrc.color"
theme_checker.w = vim.loop.new_fs_event()

function theme_checker.watch_file(fname)
  local fullpath = vim.api.nvim_call_function("fnamemodify", { fname, ":p" })

  theme_checker.w:start(
    fullpath,
    {},
    vim.schedule_wrap(function(...)
      theme_checker.on_change(...)
    end)
  )
end

function theme_checker.on_change(_, fname, _)
  vim.api.nvim_command("source " .. theme_checker.colorFile)
end

vim.api.nvim_command("source " .. theme_checker.colorFile)
theme_checker.watch_file(theme_checker.colorFile)
