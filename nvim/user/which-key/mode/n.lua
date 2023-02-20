local unmap = vim.keymap.del
local is_available = astronvim.is_available

if is_available "telescope.nvim" then
  unmap("n", "<leader>fh")
  unmap("n", "<leader>fm")
  unmap("n", "<leader>fw")
  unmap("n", "<leader>fW")
  unmap("n", "<leader>fb")
  unmap("n", "<leader>ff")
  unmap("n", "<leader>fF")
  unmap("n", "<leader>sb")
  unmap("n", "<leader>sc")
  unmap("n", "<leader>sh")
  unmap("n", "<leader>sk")
  unmap("n", "<leader>sm")
  unmap("n", "<leader>sn")
  unmap("n", "<leader>sr")
end

return {
  ["<leader>"] = {
    f = {
      name = "+[f]ind",

      g = {
        name = "+[g]it",
        ["s"] = {
          function()
            require("telescope.builtin").git_status()
          end,
          "[s]tatus files",
        },

        ["b"] = {
          function()
            require("telescope.builtin").git_branches()
          end,
          "[b]ranches",
        },

        ["c"] = {
          function()
            require("telescope.builtin").git_commits()
          end,
          "[c]ommits",
        },
      },

      b = {
        function()
          require("telescope.builtin").buffers()
        end,
        "[b]uffer",
      },

      f = {
        function()
          require("telescope.builtin").find_files()
        end,
        "in visible [f]iles",
      },

      F = {
        function()
          require("telescope.builtin").find_files { hidden = true, no_ignore = true }
        end,
        "in all [F]iles",
      },

      h = {
        function()
          require("telescope.builtin").help_tags()
        end,
        "[h]elp",
      },

      c = {
        function()
          require("telescope.builtin").commands()
        end,
        "[c]ommands",
      },

      k = {
        function()
          require("telescope.builtin").keymaps()
        end,
        "[k]eymaps",
      },

      n = {
        function()
          require("telescope").extensions.notify.notify()
        end,
        "[n]otifications",
      },

      o = {
        function()
          require("telescope.builtin").oldfiles()
        end,
        "[o]ld files",
      },

      l = {
        name = "[L]sp",
        s = {
          function()
            local aerial_avail, _ = pcall(require, "aerial")
            if aerial_avail then
              require("telescope").extensions.aerial.aerial()
            else
              require("telescope.builtin").lsp_document_symbols()
            end
          end,
          "[s]ymbols in document",
        },

        S = {
          function()
            require("telescope.builtin").lsp_document_symbols()
          end,
          "[S]ymbols in workspace",
        },

        d = {
          function()
            require("telescope.builtin").diagnostics()
          end,
          "[d]iagnostics",
        },

        i = {
          function()
            require("telescope.builtin").lsp_implementations()
          end,
          "[i]mplementations",
        },
      },

      w = {
        function()
          require("telescope.builtin").live_grep()
        end,
        "[w]ords in all visible files",
      },

      W = {
        function()
          require("telescope.builtin").live_grep {
            additional_args = function(args)
              return vim.list_extend(args, { "--hidden", "--no-ignore" })
            end,
          }
        end,
        "[W]ords in all files (also hidden)",
      },
    },

    ["."] = {
      function()
        require("telescope.builtin").find_files()
      end,
      "find files",
    },

    [","] = {
      function()
        require("telescope.builtin").buffers()
      end,
      "find buffer",
    },
  },
}
