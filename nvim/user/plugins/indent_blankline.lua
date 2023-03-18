return {
  "lukas-reineke/indent-blankline.nvim",
  opts = function()
    vim.opt.list = true
    vim.opt.listchars:append "eol:↴"

    return {
      show_end_of_line = true,
      show_current_context = true,
      show_current_context_start = true,
    }
  end,
}
