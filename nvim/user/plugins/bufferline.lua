require "bufferline"
local fn = vim.fn
local groups = require "bufferline.groups"
local fmt = string.format
local mocha = require("catppuccin.palettes").get_palette "mocha"

return {
        options = {
                offsets = {
                        {
                                text = "",
                                filetype = "neo-tree",
                                highlight = "PanelHeading",
                                text_align = "left",
                                separator = true,
                        },
                        {
                                filetype = "NvimTree",
                                text = "",
                                padding = 1,
                        },
                        {
                                filetype = "Outline",
                                text = "",
                                padding = 1,
                        },
                },
                groups = {
                        options = { toggle_hidden_on_enter = true },
                        items = {
                                groups.builtin.pinned:with { icon = "" },
                                groups.builtin.ungrouped,
                                {
                                        name = "Dependencies",
                                        icon = "",
                                        highlight = { fg = "#ECBE7B" },
                                        matcher = function(buf)
                                                return vim.startswith(buf.path,
                                                        fmt("%s/site/pack/packer", fn.stdpath "data"))
                                                    or vim.startswith(buf.path, fn.expand "$VIMRUNTIME")
                                        end,
                                },
                                {
                                        name = "tests",
                                        icon = "",
                                        matcher = function(buf)
                                                local name = buf.filename
                                                if name:match "%.sql$" == nil then
                                                        return false
                                                end
                                                return name:match "_spec" or name:match "_test" or name:match "Test"
                                        end,
                                },
                                {
                                        name = "docs",
                                        icon = "",
                                        matcher = function(buf)
                                                for _, ext in ipairs { "md", "txt", "org", "norg", "wiki" } do
                                                        if ext == fn.fnamemodify(buf.path, ":e") then
                                                                return true
                                                        end
                                                end
                                        end,
                                },
                        },
                },
                mode = "buffers",
                sort_by = "insert_after_current",
                modified_icon = astronvim.get_icon "FileModified",
                right_mouse_command = "vert sbuffer %d",
                show_close_icon = false,
                max_name_length = 14,
                max_prefix_length = 13,
                tab_size = 20,
                separator_style = "thick",
                diagnostics = "nvim_lsp",
                diagnostics_update_in_insert = true,
                hover = {
                        enabled = true,
                        reveal = { "close" },
                },
        },
        highlights = {
                fill = {
                        bg = mocha.base,
                },
                offset_separator = {
                        bg = mocha.base,
                },
                buffer_visible = {
                        bold = true,
                },
                buffer_selected = {
                        bold = true,
                },
                separator = {
                        bg = mocha.base,
                        fg = mocha.base,
                },
                indicator_selected = {
                        fg = mocha.sapphire,
                },
                background = {
                        bg = mocha.base,
                },
        },
}
