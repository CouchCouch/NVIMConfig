return {
    'akinsho/bufferline.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',

    config = function ()
        vim.opt.termguicolors = true
        require("bufferline").setup({
            options = {
                themable = true,
                separator_style = 'thick',
                modified_icon = '●',
                indicator = {
                    style = 'none',
                },
                show_buffer_icons = false,
                show_buffer_close_icons = true,
				show_tab_indicators = true,
				show_duplicate_prefix = true,
                color_icons = true,
                diagnostics = "nvim_lsp",
                diagnostics_indicator = function (count, level)
                    local icon = level:match("error") and " " or " "
                    return " ".. icon .. count
                end,
            },
        })

        vim.keymap.set("n", "<TAB>", ":bn<CR>")
        vim.keymap.set("n", "<S-TAB>", ":bp<CR>")
    end
}
