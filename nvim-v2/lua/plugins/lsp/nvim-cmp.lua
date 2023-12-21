return {
  "hrsh7th/nvim-cmp",
  event = { "InsertEnter", "CmdlineEnter" },
  dependencies = {
    "f3fora/cmp-spell",
    "hrsh7th/cmp-calc",
    "hrsh7th/cmp-emoji",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-path", -- source for file system paths
    "lukas-reineke/cmp-rg",
    "onsails/lspkind.nvim", -- vs-code like pictograms
    "rafamadriz/friendly-snippets", -- useful snippets

    -- snippets
    "L3MON4D3/LuaSnip",
    {
      "rafamadriz/friendly-snippets",
      config = function() require("luasnip.loaders.from_vscode").lazy_load() end,
    },
    "saadparwaiz1/cmp_luasnip",

    -- command line
    "hrsh7th/cmp-cmdline",
    "dmitmel/cmp-cmdline-history",

    -- search
    "hrsh7th/cmp-buffer", -- source for text in buffer

    -- dap
    "rcarriga/cmp-Dap",
  },
  config = function()
    local cmp = require "cmp"
    local luasnip = require "luasnip"
    local lspkind = require "lspkind"

    local has_words_before = function()
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
    end

    -- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup {
      completion = {
        completeopt = "menu,menuone",
      },

      window = {
        completion = cmp.config.window.bordered {
          border = "none",
          col_offset = -3,
          side_padding = 0,
          winhighlight = "Normal:CmpNormal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
        },
        documentation = cmp.config.window.bordered {
          border = "none",
          winhighlight = "Normal:CmpNormal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
        },
      },

      snippet = {
        expand = function(args) require("luasnip").lsp_expand(args.body) end,
      },

      formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
          local kind = lspkind.cmp_format {
            mode = "symbol_text",
            maxwidth = 50,
          }(entry, vim_item)

          local strings = vim.split(kind.kind, "%s", { trimempty = true })

          if strings[1] ~= "Copilot" then
            kind.kind = " " .. strings[1] .. " "
            kind.menu = "    (" .. strings[2] .. ")"
          else
            kind.kind = " " .. vim.fn.nr2char(0xe708) .. " "
            kind.menu = "    (" .. "copilot" .. ")"
          end

          return kind
        end,
      },
      view = {
        entries = { name = "custom", selection_order = "near_cursor" },
      },

      experimental = {
        ghost_text = true,
      },

      mapping = {
        ["<C-e>"] = cmp.mapping.abort(),
        ["<Down>"] = cmp.mapping.abort(),
        ["<Up>"] = cmp.mapping.abort(),

        ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
        ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            if #cmp.get_entries() == 1 then
              cmp.confirm { select = true }
            else
              cmp.select_next_item()
            end
            --[[ Replace with your snippet engine (see above sections on this page)
            -- elseif snippy.can_expand_or_advance() then
            -- snippy.expand_or_advance() ]]
          elseif has_words_before() then
            cmp.complete()
            if #cmp.get_entries() == 1 then cmp.confirm { select = true } end
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<CR>"] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Insert,
          select = true,
        },
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      },

      -- sources for autocompletion
      sources = cmp.config.sources {
        { name = "nvim_lsp" },
        { name = "nvim_lsp_signature_help" },
        { name = "luasnip" },
        { name = "path" },

        { name = "nvim_lua" },

        { name = "spell", keyword_length = 4 },
        { name = "rg", dup = 0 },

        {
          -- text within current buffer
          name = "buffer",
          option = {
            -- Avoid accidentally running on big files
            get_bufnrs = function()
              local buf = vim.api.nvim_get_current_buf()
              local byte_size = vim.api.nvim_buf_get_offset(buf, vim.api.nvim_buf_line_count(buf))
              if byte_size > 1024 * 1024 then -- 1 Megabyte max
                return {}
              end
              return { buf }
            end,
          },
        },
      },
    }

    -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline({ "/", "?" }, {
      mapping = {
        ["<CR>"] = cmp.mapping.confirm { select = true },
        ["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
        ["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
      },
      sources = {
        { name = "buffer" },
      },
    })

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(":", {
      mapping = {
        ["<CR>"] = cmp.mapping.confirm { select = true },
        ["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
        ["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
      },
      sources = {
        { name = "cmdline" },
        { name = "cmdline_history" },
        { name = "path" },
      },
    })

    -- Use dap commands completions
    require("cmp").setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
      sources = {
        { name = "dap" },
      },
    })
  end,
}
