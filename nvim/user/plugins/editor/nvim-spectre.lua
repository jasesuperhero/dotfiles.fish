return {
  "nvim-pack/nvim-spectre",
  cmd = "Spectre",
  opts = function()
    local prefix = "<leader>s"
    return {
      mapping = {
        send_to_qf = { map = prefix .. "q" },
        replace_cmd = { map = prefix .. "c" },
        show_option_menu = { map = prefix .. "o" },
        run_current_replace = { map = prefix .. "C" },
        run_replace = { map = prefix .. "R" },
        change_view_mode = { map = prefix .. "v" },
        resume_last_search = { map = prefix .. "l" },
      },
    }
  end,
}
