return {
    'akinsho/bufferline.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',

    config = function ()
        vim.opt.termguicolors = true
        local buffer_fg = '#D3C6AA'
        local selected_bg = '#493B40'
        local buffer_bg = '#2E2326'
        require("bufferline").setup{
            options = {
                themable = true,
                modified_icon = '●',
                indicator = {
                    icon = '▎',
                    style = "icon"
                },
                show_buffer_icons = false,
                show_buffer_close_icons = true,
				show_tab_indicators = true,
				show_duplicate_prefix = true,
				show_close_icon = false,
                color_icons = true,
                diagnostics = "nvim_lsp",
                diagnostics_indicator = function (count, level, diagnostics_dict, context)
                    local icon = level:match("error") and " " or " "
                    return " ".. icon .. count
                end
            },

            highlights = {
                fill = {
                    fg = buffer_fg,
                    bg = '#1E2326'
                },
                background = {
                    fg = buffer_fg,
                    bg = buffer_bg

                },

                indicator_selected = {
                    fg = buffer_fg,
                    bg = selected_bg
                },

                buffer_visible = {
                    fg = buffer_fg,
                    bg = selected_bg
                },

                tab = {
                    fg = buffer_fg,
                    bg = buffer_bg
                },
                tab_selected = {
                    fg = buffer_fg,
                    bg = selected_bg
                },
                tab_close = {
                    fg = buffer_fg,
                    bg = buffer_bg
                },

                modified = {
                    fg = '#A7C080',
                    bg = buffer_bg
                },
                modified_visible = {
                    fg = '#A7C080',
                    bg = selected_bg
                },
                modified_selected = {
                    fg = '#A7C080',
                    bg = selected_bg
                },

                buffer_selected= {
                    fg = buffer_fg,
                    bg = selected_bg,
                    bold = true
                }
            },
        }

        vim.keymap.set("n", "<TAB>", ":bn<CR>")
        vim.keymap.set("n", "<S-TAB>", ":bp<CR>")
        --vim.keymap.set("i", "<C-TAB>", ":bn<CR>")
        --vim.keymap.set("i", "<C-S-TAB>", ":bp<CR>")
    end
}
