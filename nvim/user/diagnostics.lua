-- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
return {
  underline = true,
  update_in_insert = false,
  virtual_text = true,
  virtual_lines = {
    only_current_line = true,
  },
}
