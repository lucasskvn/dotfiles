return {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
        require("bufferline").setup({
            options = {
                mode = "buffers", -- set to "tabs" to only show tabpages instead
                style_preset = require("bufferline").style_preset.default, -- or bufferline.style_preset.minimal,
                themable = true, -- allows highlight groups to be overriden i.e. sets highlights as default
                numbers = "none", -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
                close_command = "bdelete! %d", -- can be a string | function, | false see "Mouse actions"
                right_mouse_command = "bdelete! %d", -- can be a string | function | false, see "Mouse actions"
                left_mouse_command = "buffer %d", -- can be a string | function, | false see "Mouse actions"
                middle_mouse_command = nil, -- can be a string | function, | false see "Mouse actions"
                indicator = {
                    icon = '▎', -- this should be omitted if indicator style is not 'icon'
                    style = 'icon', -- | 'underline' | 'none',
                },
                buffer_close_icon = '󰅖',
                modified_icon = '●',
                close_icon = '',
                left_trunc_marker = '',
                right_trunc_marker = '',
                max_name_length = 30,
                max_prefix_length = 30, -- prefix used when a buffer is de-duplicated
                truncate_names = true, -- whether or not tab names should be truncated
                tab_size = 21,
                diagnostics = "nvim_lsp", -- | "nvim_lsp" | "coc",
                diagnostics_update_in_insert = false,
                -- The diagnostics indicator can be set to nil to keep the buffer name highlight but delete the highlighting
                diagnostics_indicator = function(count, level, diagnostics_dict, context)
                    local icon = level:match("error") and " " or " "
                    return " " .. icon .. count
                end,
                offsets = {
                    {
                        filetype = "NvimTree",
                        text = "File Explorer",
                        text_align = "left", -- | "center" | "right"
                        separator = true
                    }
                },
                color_icons = true, -- whether or not to add the filetype icon highlights
                show_buffer_icons = true, -- disable filetype icons for buffers
                show_buffer_close_icons = true,
                show_close_icon = true,
                show_tab_indicators = true,
                show_duplicate_prefix = true, -- whether to show duplicate buffer prefix
                persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
                move_wraps_at_ends = false, -- whether or not the move command "wraps" at the first or last position
                separator_style = "slant", -- | "slope" | "thick" | "thin" | { 'any', 'any' },
                enforce_regular_tabs = true,
                always_show_bufferline = true,
                hover = {
                    enabled = true,
                    delay = 200,
                    reveal = {'close'}
                },
                sort_by = 'insert_after_current', -- |'insert_at_end' | 'id' | 'extension' | 'relative_directory' | 'directory' | 'tabs' | function(buffer_a, buffer_b)
            },
            highlights = {
                separator = {
                    fg = '#073642',
                    bg = '#002b36',
                },
                separator_selected = {
                    fg = '#073642',
                },
                background = {
                    fg = '#657b83',
                    bg = '#002b36'
                },
                buffer_selected = {
                    fg = '#fdf6e3',
                    bg = '#073642',
                    bold = true,
                },
                fill = {
                    bg = '#073642'
                }
            },
        })
    end,
}
